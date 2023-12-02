# frozen_string_literal: true

class Product < ApplicationRecord
  include Discard::Model
  include Broadcast
  include IssueDiscovery
  include Importable
  include Canonical

  # Temporary attributes used when comparing similarity between two products
  attribute :item_description_similarity, :decimal, precision: 10, scale: 4
  attribute :brand_similarity, :decimal, precision: 10, scale: 4
  attribute :item_description_levenshtein_distance, :decimal, precision: 10, scale: 4

  belongs_to :external_product, class_name: 'External::Product', inverse_of: :product
  belongs_to :category, class_name: 'External::Category', optional: true
  has_many :product_duplicates, dependent: :destroy, strict_loading: true
  has_many :product_translations, dependent: :destroy, strict_loading: true
  has_many :product_issues, dependent: :destroy, strict_loading: true
  has_many :potential_duplicates, class_name: 'Product', dependent: nil
  has_many :mapped_products, class_name: 'Product', dependent: nil
  has_many :external_product_transaction_usage_counts, class_name: 'External::ProductTransactionUsageCount',
                                                       dependent: nil
  has_many :external_product_catalogue_usage_counts, class_name: 'External::ProductCatalogueUsageCount', dependent: nil
  has_many :external_product_settings_usage_counts, class_name: 'External::ProductSettingsUsageCount', dependent: nil

  has_associated_audits
  audited unless: :imported?

  scope :transaction_count, -> {}

  before_validation :clean, unless: :imported?

  validates :external_product_id, presence: true, uniqueness: true
  validates :buy_list_count, :catalogue_count, :inventory_barcodes_count,
            :inventory_derived_period_balances_count, :inventory_internal_requisition_lines_count,
            :inventory_stock_counts_count, :inventory_stock_levels_count, :inventory_transfer_items_count,
            :invoice_line_items_count, :point_of_sale_lines_count, :procurement_products_count,
            :product_supplier_preferences_count, :purchase_order_line_items_count, :rebates_profile_products_count,
            :receiving_document_line_items_count, :recipes_count, :requisition_line_items_count,
            :credit_note_lines_count, :linked_products_count, :price_count,
            numericality: { greater_than_or_equal_to: 0, only_integer: true }, allow_nil: true
  validates :duplication_certainty, :canonical_certainty, :average_price, :maximum_price, :minimum_price,
            :standard_deviation, :median_price,
            numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  delegate :catalogue_usage_attributes, :transaction_usage_attributes, :settings_usage_attributes, to: :class

  after_discard do
    broadcast_resource_deletion
  end

  class << self
    # Used by ransack to allow a scope to be applied as a filter
    # For example { kept: true } in the ProductsController
    def ransackable_scopes(*)
      %i[kept]
    end

    def ransackable_attributes(auth_object = nil)
      %w[action average_price brand buy_list_count canonical canonical_certainty catalogue_count category_id category_path collected_certainty_at collected_pricing_at collected_usage_at created_at credit_note_lines_count data_source discarded_at duplication_certainty external_product_id id image_file_name image_updated_at inventory_barcodes_count inventory_derived_period_balances_count inventory_internal_requisition_lines_count inventory_stock_counts_count inventory_stock_levels_count inventory_transfer_items_count invoice_line_items_count item_description item_measure item_pack_name item_sell_pack_name item_sell_quantity item_size last_synced_at linked_products_count locale maximum_price median_price minimum_price point_of_sale_lines_count price_count price_country priced_catalogue_count procurement_products_count product_duplicates_count product_issues_count product_issues_outstanding_count product_supplier_preferences_count product_translations_count purchase_order_line_items_count rebates_profile_products_count receiving_document_line_items_count recipes_count requisition_line_items_count standard_deviation updated_at volume_in_litres]
    end

    def catalogue_usage_attributes
      %w[catalogue_count recipes_count inventory_stock_levels_count inventory_derived_period_balances_count]
    end

    def transaction_usage_attributes
      %w[
        invoice_line_items_count requisition_line_items_count purchase_order_line_items_count
        receiving_document_line_items_count inventory_internal_requisition_lines_count inventory_transfer_items_count
        inventory_stock_counts_count point_of_sale_lines_count credit_note_lines_count
      ]
    end

    def settings_usage_attributes
      %w[
        inventory_barcodes_count procurement_products_count product_supplier_preferences_count
        rebates_profile_products_count linked_products_count
      ]
    end
  end

  # This is the URL where PurchasePlus stores images for central catalogue items
  # @return [String] full URL to retrieve the product image
  def image_url
    "https://cdn.purchaseplus.com/images/products/#{image_file_name}" if image_file_name
  end

  # Use this when the product changes should possibly be propagated to the external product as well.
  # This will only occur if the attributes changed match those being mirrored from the external product.
  # @param [Hash] attributes the changed attributes to save
  # @return [Boolean] true if the update was successful, false otherwise
  def update_and_propagate(attributes)
    saved = update(attributes)
    # TODO: Perform asynchronously
    if saved && Tasks::UpdateExternalProduct.executable?(previous_changes)
      Tasks::UpdateExternalProduct.create!(context: self).tap(&:call)
    end
    saved
  end

  # A string representation of the Product that is used whenever an instance is converted to a string
  # @return [String] the item_description of the Product
  def to_s
    item_description
  end

  # A more detailed representation of the Product
  # @return [String] a concatenation of the Product attributes for description, brand, unit size, sell size and
  # the category (if there is one)
  def long_description
    [
      [brand, item_description].compact,
      [format('%g', item_size), item_measure].compact.join(''),
      item_pack_name,
      sell_size_description,
      ("(#{category_path})" if category_path.present?),
      "[PPID: #{external_product_id}]"
    ].compact.join(' ')
  end

  # A description of the sell size that makes it more human readable
  # @return [String] the item_sell_pack_name only if it is "1 each" otherwise the concatenation of
  # item_sell_pack_name, "of", and the significant digits of item_sell_quantity
  def sell_size_description
    return item_sell_pack_name if item_sell_quantity == 1 && item_sell_pack_name == 'each'

    [item_sell_pack_name, 'of', format('%g', item_sell_quantity)].join(' ')
  end

  # @return [Boolean] has this product been used in any catalogue, transaction or setting?
  def used?
    ((catalogue_usage_count || 0) + (transaction_usage_count || 0) + (settings_usage_count || 0)).positive?
  end

  # @return [BigDecimal] what is the percentage likelihood this product has been duplicated elsewhere?
  def calculate_duplication_certainty
    return 0 if product_duplicates.none?

    product_duplicates.most_likely.average(:certainty_percentage) || 0
  end

  # @return [BigDecimal] what is the percentage likelihood this product is the "real" product?
  def calculate_canonical_certainty
    return 1 if product_duplicates.none?

    1 - canonical_red_flag_penalties
  end

  # @return [Integer] a count of the catalogues or catalogue-like locations where the product is in use
  def catalogue_usage_count
    @catalogue_usage_count ||=
      Queries::ProductUsageCounts
      .call(options: { attributes: catalogue_usage_attributes, product_id: id })
      .take
      .usage_count
  end

  # @return [String] a string representation of the usage of this product on catalogue type data structures
  # in comparison to all other products. Can be `none`, `lowest`, `low`, `medium`, `highest`
  def catalogue_usage_ranking
    usage_ranking(count: catalogue_usage_count, quartiles: quartiles(attributes: catalogue_usage_attributes))
  end

  def transaction_usage_count
    @transaction_usage_count ||=
      Queries::ProductUsageCounts
      .call(options: { attributes: transaction_usage_attributes, product_id: id })
      .take
      .usage_count
  end

  def transaction_usage_ranking
    usage_ranking(count: transaction_usage_count, quartiles: quartiles(attributes: transaction_usage_attributes))
  end

  def settings_usage_count
    @settings_usage_count ||=
      Queries::ProductUsageCounts
      .call(options: { attributes: settings_usage_attributes, product_id: id })
      .take
      .usage_count
  end

  def settings_usage_ranking
    usage_ranking(count: settings_usage_count, quartiles: quartiles(attributes: settings_usage_attributes))
  end

  # Look for any issues and automatically fix them when possible
  def discover_and_fix_issues!
    possible_issues.each do |issue|
      next if issue.already_identified?

      issue.save!
      issue.fix! if issue.confirmed?
    end
  end

  # Mark any issues that have already been resolved as fixed
  def resolve_issues!
    product_issues.each do |issue|
      issue.fixed! unless issue.issue?
    end
  end

  def possible_issues
    super | product_translations.map(&:possible_issues).flatten
  end

  private

  def clean
    assign_attributes(
      item_description: item_description&.squeeze(' ')&.strip.presence,
      brand: brand&.squeeze(' ')&.strip.presence
    )
  end

  def usage_ranking(count:, quartiles:)
    case count
    when 0
      'none'
    when 1..quartiles.low
      'lowest'
    when (quartiles.low + 1)..quartiles.medium
      'low'
    when (quartiles.medium + 1)..quartiles.high
      'medium'
    else
      'high'
    end
  end

  def quartiles(attributes:)
    Queries::UsageQuartiles.call(
      scope: self.class.all, options: { attributes: attributes }
    )
  end
end
