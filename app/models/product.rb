# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :product_duplicates, dependent: :destroy
  has_associated_audits

  audited

  validates :product_id, presence: true, uniqueness: true
  validates :buy_list_count, :spelling_mistakes, :catalogue_count, :inventory_barcodes_count,
            :inventory_derived_period_balances_count, :inventory_internal_requisition_lines_count,
            :inventory_stock_counts_count, :inventory_stock_levels_count, :inventory_transfer_items_count,
            :invoice_line_items_count, :point_of_sale_lines_count, :procurement_products_count,
            :product_supplier_preferences_count, :purchase_order_line_items_count, :rebates_profile_products_count,
            :receiving_document_line_items_count, :recipes_count, :requisition_line_items_count,
            numericality: { greater_than_or_equal_to: 0, only_integer: true }, allow_nil: true
  validates :duplication_certainty, :canonical_certainty, :average_price, :maximum_price, :minimum_price,
            :standard_deviation, :variance, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  def to_s
    ''
  end
end
