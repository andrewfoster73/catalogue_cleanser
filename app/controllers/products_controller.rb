# frozen_string_literal: true

class ProductsController < ResourcesController
  private

  # Only allow a list of trusted parameters through.
  def permitted_params
    super | %i[
      product_id status duplication_certainty canonical_certainty action collected_statistics_at spelling_mistakes
      catalogue_count buy_list_count priced_catalogue_count average_price maximum_price minimum_price standard_deviation
      variance inventory_barcodes_count inventory_derived_period_balances_count
      inventory_internal_requisition_lines_count inventory_stock_counts_count inventory_stock_levels_count
      inventory_transfer_items_count invoice_line_items_count point_of_sale_lines_count procurement_products_count
      product_supplier_preferences_count purchase_order_line_items_count rebates_profile_products_count
      receiving_document_line_items_count recipes_count requisition_line_items_count
    ]
  end
end
