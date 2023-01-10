# frozen_string_literal: true

class Product < ApplicationRecord
  include Discard::Model
  include Broadcast
  include IssueDiscovery
  include Importable

  belongs_to :external_product, class_name: 'External::Product', inverse_of: :product
  belongs_to :category, class_name: 'External::Category', optional: true
  has_many :product_duplicates, dependent: :destroy, strict_loading: true
  has_many :product_translations, dependent: :destroy, strict_loading: true
  has_many :product_issues, dependent: :destroy, strict_loading: true
  has_many :external_product_transaction_usage_counts, class_name: 'External::ProductTransactionUsageCount',
                                                       dependent: nil
  has_many :external_product_catalogue_usage_counts, class_name: 'External::ProductCatalogueUsageCount', dependent: nil
  has_many :external_product_catalogue_usage_counts, class_name: 'External::ProductCatalogueUsageCount', dependent: nil

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

  # @return [Boolean] has this product been used in any catalogue, transaction or setting?
  def used?
    ((catalogue_usage_count || 0) + (transaction_usage_count || 0) + (settings_usage_count || 0)).positive?
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
