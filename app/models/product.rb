# frozen_string_literal: true

class Product < ApplicationRecord
  include Broadcast
  include IssueDiscovery

  belongs_to :external_product, class_name: 'External::Product', inverse_of: :product
  has_many :product_duplicates, dependent: :destroy, strict_loading: true
  has_many :product_translations, dependent: :destroy, strict_loading: true
  has_many :product_issues, dependent: :destroy, strict_loading: true
  has_many :external_product_usage_counts, class_name: 'External::ProductUsageCount', dependent: nil

  has_associated_audits
  audited

  validates :external_product_id, presence: true, uniqueness: true
  validates :buy_list_count, :catalogue_count, :inventory_barcodes_count,
            :inventory_derived_period_balances_count, :inventory_internal_requisition_lines_count,
            :inventory_stock_counts_count, :inventory_stock_levels_count, :inventory_transfer_items_count,
            :invoice_line_items_count, :point_of_sale_lines_count, :procurement_products_count,
            :product_supplier_preferences_count, :purchase_order_line_items_count, :rebates_profile_products_count,
            :receiving_document_line_items_count, :recipes_count, :requisition_line_items_count,
            numericality: { greater_than_or_equal_to: 0, only_integer: true }, allow_nil: true
  validates :duplication_certainty, :canonical_certainty, :average_price, :maximum_price, :minimum_price,
            :standard_deviation, :variance, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  def image_url
    "https://cdn.purchaseplus.com/images/products/#{image_file_name}" if image_file_name
  end

  def to_s
    item_description
  end

  def catalogue_usage_count
    @catalogue_usage_count ||= [
      catalogue_count, recipes_count, inventory_stock_levels_count,
      inventory_derived_period_balances_count
    ].compact.sum
  end

  def catalogue_usage_ranking
    usage_ranking(count: catalogue_usage_count, quartiles: catalogue_quartiles)
  end

  def transaction_usage_count
    @transaction_usage_count ||= [
      invoice_line_items_count, requisition_line_items_count, purchase_order_line_items_count,
      receiving_document_line_items_count, inventory_internal_requisition_lines_count, inventory_transfer_items_count,
      inventory_stock_counts_count, point_of_sale_lines_count
    ].compact.sum
  end

  def transaction_usage_ranking
    usage_ranking(count: transaction_usage_count, quartiles: transaction_quartiles)
  end

  def settings_usage_count
    @settings_usage_count ||= [
      inventory_barcodes_count, procurement_products_count, product_supplier_preferences_count,
      rebates_profile_products_count
    ].compact.sum
  end

  def settings_usage_ranking
    usage_ranking(count: settings_usage_count, quartiles: settings_quartiles)
  end

  def discover_issues!
    possible_issues.each { |issue| issue.save! unless issue.already_identified? }

    # [Spelling Mistakes]
    # [Missing Volume In Litres]
    # [Brand Incorrect]
    # [Item Measure Incorrect]
    # [Item Pack Incorrect]
    # [Item Sell Pack Name Incorrect]
    # [Incorrect Translation]
    # [Illegal Translation]
    # [Missing Translation]
    # [Possible Duplication]
    # [UpperCase -> LowerCase]
    # [All Upper]
    # [Missing Category]
    # [Brand in Product]
    # [Missing Image]
  end

  def resolve_issues!
    product_issues.each do |issue|
      issue.fixed! unless issue.issue?
    end
  end

  def possible_issues
    super | product_translations.map(&:possible_issues).flatten
  end

  private

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

  def transaction_quartiles
    @transaction_quartiles ||= Queries::TransactionUsageQuartiles.call
  end

  def catalogue_quartiles
    @catalogue_quartiles ||= Queries::CatalogueUsageQuartiles.call
  end

  def settings_quartiles
    @settings_quartiles ||= Queries::SettingsUsageQuartiles.call
  end

  # def broadcast_update?
  #   false
  # end
end
