# frozen_string_literal: true

require 'test_helper'

class ProductUsage::ComponentTest < ViewComponent::TestCase
  def setup
    @product = products(:lager)
  end

  test 'renders usage ranking and counts' do
    render_inline ProductUsage::Component.new(resource: @product)

    assert_selector("#product_#{@product.id}--transaction_usage_count__heading", text: 'Transactions')
    assert_selector("#product_#{@product.id}--transaction_usage_count__value", text: '76')
    assert_selector("#product_#{@product.id}--catalogue_usage_count__heading", text: 'Catalogues')
    assert_selector("#product_#{@product.id}--catalogue_usage_count__value", text: '27')
    assert_selector("#product_#{@product.id}--settings_usage_count__heading", text: 'Settings')
    assert_selector("#product_#{@product.id}--settings_usage_count__value", text: '23')

    assert_selector("#product_#{@product.id}--requisition_line_items_count__heading", text: 'Requisitions')
    assert_selector("#product_#{@product.id}--requisition_line_items_count__value", text: '0')
    assert_selector("#product_#{@product.id}--purchase_order_line_items_count__heading", text: 'Purchase Orders')
    assert_selector("#product_#{@product.id}--purchase_order_line_items_count__value", text: '1')
    assert_selector("#product_#{@product.id}--invoice_line_items_count__heading", text: 'Invoices')
    assert_selector("#product_#{@product.id}--invoice_line_items_count__value", text: '1')
    assert_selector("#product_#{@product.id}--credit_note_lines_count__heading", text: 'Credit Notes')
    assert_selector("#product_#{@product.id}--credit_note_lines_count__value", text: '9')
    assert_selector("#product_#{@product.id}--receiving_document_line_items_count__heading", text: 'Receiving Documents')
    assert_selector("#product_#{@product.id}--receiving_document_line_items_count__value", text: '1')
    assert_selector("#product_#{@product.id}--inventory_internal_requisition_lines_count__heading", text: 'Internal Requisitions')
    assert_selector("#product_#{@product.id}--inventory_internal_requisition_lines_count__value", text: '1')
    assert_selector("#product_#{@product.id}--inventory_transfer_items_count__heading", text: 'Transfers')
    assert_selector("#product_#{@product.id}--inventory_transfer_items_count__value", text: '1')
    assert_selector("#product_#{@product.id}--inventory_stock_counts_count__heading", text: 'Stock Counts')
    assert_selector("#product_#{@product.id}--inventory_stock_counts_count__value", text: '1')
    assert_selector("#product_#{@product.id}--point_of_sale_lines_count__heading", text: 'Point of Sale')
    assert_selector("#product_#{@product.id}--point_of_sale_lines_count__value", text: '1')
    assert_selector("#product_#{@product.id}--catalogue_count__heading", text: 'Catalogues')
    assert_selector("#product_#{@product.id}--catalogue_count__value", text: '24')
    assert_selector("#product_#{@product.id}--buy_list_count__heading", text: 'Buy Lists')
    assert_selector("#product_#{@product.id}--buy_list_count__value", text: '12')
    assert_selector("#product_#{@product.id}--priced_catalogue_count__heading", text: 'Priced Catalogues')
    assert_selector("#product_#{@product.id}--priced_catalogue_count__value", text: '12')
    assert_selector("#product_#{@product.id}--recipes_count__heading", text: 'Recipes')
    assert_selector("#product_#{@product.id}--recipes_count__value", text: '1')
    assert_selector("#product_#{@product.id}--inventory_stock_levels_count__heading", text: 'Stock Levels')
    assert_selector("#product_#{@product.id}--inventory_stock_levels_count__value", text: '1')
    assert_selector("#product_#{@product.id}--inventory_derived_period_balances_count__heading", text: 'Derived Period Balances')
    assert_selector("#product_#{@product.id}--inventory_derived_period_balances_count__value", text: '1')
    assert_selector("#product_#{@product.id}--inventory_barcodes_count__heading", text: 'Barcodes')
    assert_selector("#product_#{@product.id}--inventory_barcodes_count__value", text: '9')
    assert_selector("#product_#{@product.id}--procurement_products_count__heading", text: 'Procurement Products')
    assert_selector("#product_#{@product.id}--procurement_products_count__value", text: '1')
    assert_selector("#product_#{@product.id}--product_supplier_preferences_count__heading", text: 'Product Supplier Preferences')
    assert_selector("#product_#{@product.id}--product_supplier_preferences_count__value", text: '1')
    assert_selector("#product_#{@product.id}--rebates_profile_products_count__heading", text: 'Rebate Profiles')
    assert_selector("#product_#{@product.id}--rebates_profile_products_count__value", text: '1')
  end
end
