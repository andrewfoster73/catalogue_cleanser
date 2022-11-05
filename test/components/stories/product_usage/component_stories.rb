# frozen_string_literal: true

module ProductUsage
  class ComponentStories < ApplicationStories
    story :basic do
      constructor(
        resource: klazz(
          Product,
          collected_statistics_at: Time.zone.now,
          catalogue_count: 1,
          buy_list_count: 1,
          priced_catalogue_count: 1,
          inventory_barcodes_count: 1,
          inventory_derived_period_balances_count: 1,
          inventory_internal_requisition_lines_count: 1,
          inventory_stock_counts_count: 1,
          inventory_stock_levels_count: 1,
          inventory_transfer_items_count: 1,
          invoice_line_items_count: 1,
          point_of_sale_lines_count: 1,
          procurement_products_count: 1,
          product_supplier_preferences_count: 1,
          purchase_order_line_items_count: 1,
          rebates_profile_products_count: 1,
          receiving_document_line_items_count: 1,
          recipes_count: 1,
          requisition_line_items_count: 5400
        )
      )
    end
  end
end
