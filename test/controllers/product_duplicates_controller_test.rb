# frozen_string_literal: true

require 'test_helper'

class ProductDuplicatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_duplicate = product_duplicates(:one)
  end

  test 'should get index' do
    get product_duplicates_url
    assert_response :success
  end

  test 'should get new' do
    get new_product_duplicate_url
    assert_response :success
  end

  test 'should create product_duplicate' do
    assert_difference('ProductDuplicate.count') do
      post product_duplicates_url,
           params: {
             product_duplicate: {
               action: @product_duplicate.action,
               canonical_product_id: @product_duplicate.canonical_product_id,
               certainty_percentage: @product_duplicate.certainty_percentage,
               levenshtein_distance: @product_duplicate.levenshtein_distance,
               mapped_product_id: @product_duplicate.mapped_product_id,
               product_id: @product_duplicate.product_id,
               similarity_score: @product_duplicate.similarity_score
             }
           }
    end

    assert_redirected_to product_duplicate_url(ProductDuplicate.last, format: :html)
  end

  test 'should show product_duplicate' do
    get product_duplicate_url(@product_duplicate)
    assert_response :success
  end

  test 'should get edit' do
    get edit_product_duplicate_url(@product_duplicate)
    assert_response :success
  end

  test 'should update product_duplicate' do
    patch product_duplicate_url(@product_duplicate),
          params: {
            product_duplicate: {
              action: @product_duplicate.action,
              canonical_product_id: @product_duplicate.canonical_product_id,
              certainty_percentage: @product_duplicate.certainty_percentage,
              levenshtein_distance: @product_duplicate.levenshtein_distance,
              mapped_product_id: @product_duplicate.mapped_product_id,
              product_id: @product_duplicate.product_id,
              similarity_score: @product_duplicate.similarity_score
            }
          }
    assert_redirected_to product_duplicate_url(@product_duplicate)
  end

  test 'should destroy product_duplicate' do
    assert_difference('ProductDuplicate.count', -1) do
      delete product_duplicate_url(@product_duplicate)
    end

    assert_redirected_to product_duplicates_url
  end
end
