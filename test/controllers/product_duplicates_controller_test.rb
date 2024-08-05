# frozen_string_literal: true

require 'test_helper'

class ProductDuplicatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_duplicate = product_duplicates(:lager)
  end

  test 'should redirect if not authenticated' do
    get product_duplicates_url
    assert_redirected_to :root
  end

  test 'should get index' do
    authenticate
    get product_duplicates_url
    assert_response :success
  end

  test 'should update product_duplicate' do
    authenticate
    patch product_duplicate_url(@product_duplicate),
          params: {
            product_duplicate: {
              action: @product_duplicate.action,
              potential_duplicate_product_id: @product_duplicate.potential_duplicate_product_id,
              certainty_percentage: @product_duplicate.certainty_percentage,
              item_description_levenshtein_distance: @product_duplicate.item_description_levenshtein_distance,
              mapped_product_id: @product_duplicate.mapped_product_id,
              product_id: @product_duplicate.product_id,
              item_description_similarity_score: @product_duplicate.item_description_similarity_score
            }
          }
    assert_redirected_to product_duplicates_url(format: :html)
  end

  test 'should destroy product_duplicate' do
    authenticate
    assert_difference('ProductDuplicate.count', -1) do
      delete product_duplicate_url(@product_duplicate)
    end

    assert_redirected_to product_duplicates_url
  end
end
