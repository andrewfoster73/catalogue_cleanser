# frozen_string_literal: true

require 'test_helper'

class ProductTranslationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_translation = product_translations(:lager)
  end

  test 'should redirect if not authenticated' do
    get product_translations_url
    assert_redirected_to :root
  end

  test 'should get index' do
    authenticate
    get product_translations_url
    assert_response :success
  end

  test 'should create product_translation' do
    authenticate
    @product = create(:product)
    assert_difference('ProductTranslation.count') do
      post product_translations_url,
           params: {
             product_translation: {
               product_id: @product.id,
               locale: @product_translation.locale,
               item_description: @product_translation.item_description,
               brand: @product_translation.brand,
               item_size: @product_translation.item_size,
               item_measure: @product_translation.item_measure,
               item_pack_name: @product_translation.item_pack_name,
               item_sell_quantity: @product_translation.item_sell_quantity,
               item_sell_pack_name: @product_translation.item_sell_pack_name
             }
           }
    end

    assert_redirected_to product_translation_url(ProductTranslation.last, format: :html)
  end

  test 'should show product_translation' do
    authenticate
    get product_translation_url(@product_translation)
    assert_response :success
  end

  test 'should get edit' do
    authenticate
    get edit_product_translation_url(@product_translation)
    assert_response :success
  end

  test 'should update product_translation' do
    authenticate
    patch product_translation_url(@product_translation),
          params: {
            product_translation: {
              locale: @product_translation.locale,
              item_description: @product_translation.item_description,
              brand: @product_translation.brand,
              item_size: @product_translation.item_size,
              item_measure: @product_translation.item_measure,
              item_pack_name: @product_translation.item_pack_name,
              item_sell_quantity: @product_translation.item_sell_quantity,
              item_sell_pack_name: @product_translation.item_sell_pack_name
            }
          }
    assert_redirected_to product_translation_url(@product_translation, format: :html)
  end

  test 'should destroy product_translation' do
    authenticate
    assert_difference('ProductTranslation.count', -1) do
      delete product_translation_url(@product_translation)
    end

    assert_redirected_to product_translations_url
  end
end
