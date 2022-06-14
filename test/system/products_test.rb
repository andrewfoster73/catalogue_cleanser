# frozen_string_literal: true

require 'application_system_test_case'

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test 'visiting the index' do
    visit products_url
    assert_selector 'h1', text: 'Products'
  end

  test 'should create product' do
    visit products_url
    click_on 'New product'

    fill_in 'Action', with: @product.action
    fill_in 'Average price', with: @product.average_price
    fill_in 'Buy list count', with: @product.buy_list_count
    fill_in 'Canonical certainty', with: @product.canonical_certainty
    fill_in 'Catalogue count', with: @product.catalogue_count
    fill_in 'Collected statistics at', with: @product.collected_statistics_at
    fill_in 'Duplication certainty', with: @product.duplication_certainty
    fill_in 'Inventory barcodes count', with: @product.inventory_barcodes_count
    fill_in 'Inventory derived period balances count', with: @product.inventory_derived_period_balances_count
    fill_in 'Inventory internal requisition lines count', with: @product.inventory_internal_requisition_lines_count
    fill_in 'Inventory stock counts count', with: @product.inventory_stock_counts_count
    fill_in 'Inventory stock levels count', with: @product.inventory_stock_levels_count
    fill_in 'Inventory transfer items count', with: @product.inventory_transfer_items_count
    fill_in 'Invoice line items count', with: @product.invoice_line_items_count
    fill_in 'Maximum price', with: @product.maximum_price
    fill_in 'Minimum price', with: @product.minimum_price
    fill_in 'Point of sale lines count', with: @product.point_of_sale_lines_count
    fill_in 'Priced catalogue count', with: @product.priced_catalogue_count
    fill_in 'Procurement products count', with: @product.procurement_products_count
    fill_in 'Product', with: Product.maximum(:id) + 1
    fill_in 'Product supplier preferences count', with: @product.product_supplier_preferences_count
    fill_in 'Purchase order line items count', with: @product.purchase_order_line_items_count
    fill_in 'Rebates profile products count', with: @product.rebates_profile_products_count
    fill_in 'Receiving document line items count', with: @product.receiving_document_line_items_count
    fill_in 'Recipes count', with: @product.recipes_count
    fill_in 'Requisition line items count', with: @product.requisition_line_items_count
    fill_in 'Spelling mistakes', with: @product.spelling_mistakes
    fill_in 'Standard deviation', with: @product.standard_deviation
    fill_in 'Status', with: @product.status
    fill_in 'Variance', with: @product.variance
    click_on 'Create Product'

    assert_text 'Product was successfully created'
    click_on 'Back'
  end

  test 'should update Product' do
    visit product_url(@product)
    click_on 'Edit this product', match: :first

    fill_in 'Action', with: @product.action
    fill_in 'Average price', with: @product.average_price
    fill_in 'Buy list count', with: @product.buy_list_count
    fill_in 'Canonical certainty', with: @product.canonical_certainty
    fill_in 'Catalogue count', with: @product.catalogue_count
    fill_in 'Collected statistics at', with: @product.collected_statistics_at
    fill_in 'Duplication certainty', with: @product.duplication_certainty
    fill_in 'Inventory barcodes count', with: @product.inventory_barcodes_count
    fill_in 'Inventory derived period balances count', with: @product.inventory_derived_period_balances_count
    fill_in 'Inventory internal requisition lines count', with: @product.inventory_internal_requisition_lines_count
    fill_in 'Inventory stock counts count', with: @product.inventory_stock_counts_count
    fill_in 'Inventory stock levels count', with: @product.inventory_stock_levels_count
    fill_in 'Inventory transfer items count', with: @product.inventory_transfer_items_count
    fill_in 'Invoice line items count', with: @product.invoice_line_items_count
    fill_in 'Maximum price', with: @product.maximum_price
    fill_in 'Minimum price', with: @product.minimum_price
    fill_in 'Point of sale lines count', with: @product.point_of_sale_lines_count
    fill_in 'Priced catalogue count', with: @product.priced_catalogue_count
    fill_in 'Procurement products count', with: @product.procurement_products_count
    fill_in 'Product', with: @product.product_id
    fill_in 'Product supplier preferences count', with: @product.product_supplier_preferences_count
    fill_in 'Purchase order line items count', with: @product.purchase_order_line_items_count
    fill_in 'Rebates profile products count', with: @product.rebates_profile_products_count
    fill_in 'Receiving document line items count', with: @product.receiving_document_line_items_count
    fill_in 'Recipes count', with: @product.recipes_count
    fill_in 'Requisition line items count', with: @product.requisition_line_items_count
    fill_in 'Spelling mistakes', with: @product.spelling_mistakes
    fill_in 'Standard deviation', with: @product.standard_deviation
    fill_in 'Status', with: @product.status
    fill_in 'Variance', with: @product.variance
    click_on 'Update Product'

    assert_text 'Product was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Product' do
    visit product_url(@product)
    click_on 'Destroy this product', match: :first

    assert_text 'Product was successfully destroyed'
  end
end
