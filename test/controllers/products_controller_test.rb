# frozen_string_literal: true

require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:lager)
  end

  test 'should redirect if not authenticated' do
    get products_url
    assert_redirected_to :root
  end

  test 'should get index' do
    authenticate
    get products_url
    assert_response :success
  end

  test 'should show product' do
    authenticate
    get product_url(@product)
    assert_response :success
  end

  test 'should get edit' do
    authenticate
    get edit_product_url(@product)
    assert_response :success
  end

  test 'should update product' do
    authenticate
    patch product_url(@product),
          params: {
            product: {
              action: @product.action,
              average_price: @product.average_price,
              buy_list_count: @product.buy_list_count,
              canonical_certainty: @product.canonical_certainty,
              catalogue_count: @product.catalogue_count,
              collected_usage_at: @product.collected_usage_at,
              duplication_certainty: @product.duplication_certainty,
              inventory_barcodes_count: @product.inventory_barcodes_count,
              inventory_derived_period_balances_count: @product.inventory_derived_period_balances_count,
              inventory_internal_requisition_lines_count: @product.inventory_internal_requisition_lines_count,
              inventory_stock_counts_count: @product.inventory_stock_counts_count,
              inventory_stock_levels_count: @product.inventory_stock_levels_count,
              inventory_transfer_items_count: @product.inventory_transfer_items_count,
              invoice_line_items_count: @product.invoice_line_items_count,
              credit_note_lines_count: @product.credit_note_lines_count,
              maximum_price: @product.maximum_price,
              minimum_price: @product.minimum_price,
              point_of_sale_lines_count: @product.point_of_sale_lines_count,
              priced_catalogue_count: @product.priced_catalogue_count,
              procurement_products_count: @product.procurement_products_count,
              linked_products_count: @product.linked_products_count,
              external_product_id: @product.external_product_id,
              product_supplier_preferences_count: @product.product_supplier_preferences_count,
              purchase_order_line_items_count: @product.purchase_order_line_items_count,
              rebates_profile_products_count: @product.rebates_profile_products_count,
              receiving_document_line_items_count: @product.receiving_document_line_items_count,
              recipes_count: @product.recipes_count,
              requisition_line_items_count: @product.requisition_line_items_count,
              standard_deviation: @product.standard_deviation,
              item_description: @product.item_description,
              brand: @product.brand,
              item_size: @product.item_size,
              item_measure: @product.item_measure,
              item_pack_name: @product.item_pack_name,
              item_sell_quantity: @product.item_sell_quantity,
              item_sell_pack_name: @product.item_sell_pack_name
            }
          }
    assert_redirected_to product_url(@product, format: :html)
  end

  test 'should resolve an issues that were fixed by the update' do
    authenticate
    product = create(:product, item_description: nil)
    product = Product.includes(:product_translations, :product_issues).find(product.id)
    product.discover_and_fix_issues!
    assert_equal(1, product.product_issues.size)

    patch product_url(product),
          params: {
            product: {
              item_description: 'Corn'
            }
          }

    issue = ProductIssue.find_by(product_id: product.id, type: 'ProductIssues::MissingCompulsory')
    assert_equal('fixed', issue.status)
  end

  test 'should soft delete product' do
    authenticate
    delete product_url(@product)
    assert_not_nil(@product.reload.discarded_at)

    assert_redirected_to products_url
  end
end
