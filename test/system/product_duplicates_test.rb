# frozen_string_literal: true

require 'application_system_test_case'

class ProductDuplicatesTest < ApplicationSystemTestCase
  setup do
    @product_duplicate = product_duplicates(:one)
  end

  test 'visiting the index' do
    visit product_duplicates_url
    assert_selector 'h1', text: 'Product duplicates'
  end

  test 'should create product duplicate' do
    visit product_duplicates_url
    click_on 'New product duplicate'

    fill_in 'Action', with: @product_duplicate.action
    fill_in 'Canonical product', with: @product_duplicate.canonical_product_id
    fill_in 'Certainty percentage', with: @product_duplicate.certainty_percentage
    fill_in 'Levenshtein distance', with: @product_duplicate.levenshtein_distance
    fill_in 'Mapped product', with: @product_duplicate.mapped_product_id
    fill_in 'Product', with: @product_duplicate.product_id
    fill_in 'Similarity score', with: @product_duplicate.similarity_score
    click_on 'Create Product duplicate'

    assert_text "Product duplicate '#{@product_duplicate}' was successfully created"
    click_on 'Back'
  end

  test 'should update Product duplicate' do
    visit product_duplicate_url(@product_duplicate)
    click_on 'Edit this product duplicate', match: :first

    fill_in 'Action', with: @product_duplicate.action
    fill_in 'Canonical product', with: @product_duplicate.canonical_product_id
    fill_in 'Certainty percentage', with: @product_duplicate.certainty_percentage
    fill_in 'Levenshtein distance', with: @product_duplicate.levenshtein_distance
    fill_in 'Mapped product', with: @product_duplicate.mapped_product_id
    fill_in 'Product', with: @product_duplicate.product_id
    fill_in 'Similarity score', with: @product_duplicate.similarity_score
    click_on 'Update Product duplicate'

    assert_text "Product duplicate '#{@product_duplicate}' was successfully updated"
    click_on 'Back'
  end

  test 'should destroy Product duplicate' do
    visit product_duplicate_url(@product_duplicate)
    click_on 'Destroy this product duplicate', match: :first

    assert_text "Product duplicate '#{@product_duplicate}' was successfully deleted"
  end
end
