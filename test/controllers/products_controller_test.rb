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
              collected_statistics_at: @product.collected_statistics_at,
              duplication_certainty: @product.duplication_certainty,
              inventory_barcodes_count: @product.inventory_barcodes_count,
              inventory_derived_period_balances_count: @product.inventory_derived_period_balances_count,
              inventory_internal_requisition_lines_count: @product.inventory_internal_requisition_lines_count,
              inventory_stock_counts_count: @product.inventory_stock_counts_count,
              inventory_stock_levels_count: @product.inventory_stock_levels_count,
              inventory_transfer_items_count: @product.inventory_transfer_items_count,
              invoice_line_items_count: @product.invoice_line_items_count,
              maximum_price: @product.maximum_price,
              minimum_price: @product.minimum_price,
              point_of_sale_lines_count: @product.point_of_sale_lines_count,
              priced_catalogue_count: @product.priced_catalogue_count,
              procurement_products_count: @product.procurement_products_count,
              product_id: @product.product_id,
              product_supplier_preferences_count: @product.product_supplier_preferences_count,
              purchase_order_line_items_count: @product.purchase_order_line_items_count,
              rebates_profile_products_count: @product.rebates_profile_products_count,
              receiving_document_line_items_count: @product.receiving_document_line_items_count,
              recipes_count: @product.recipes_count,
              requisition_line_items_count: @product.requisition_line_items_count,
              standard_deviation: @product.standard_deviation,
              variance: @product.variance,
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

  test 'should destroy product' do
    authenticate
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
