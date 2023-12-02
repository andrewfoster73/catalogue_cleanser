# frozen_string_literal: true

require 'application_system_test_case'

class ProductDuplicatesTest < ApplicationSystemTestCase
  setup do
    @product_duplicate = product_duplicates(:lager)
    @product = @product_duplicate.product
  end

  test 'redirects if not logged in' do
    visit product_duplicates_url
    assert_current_path(root_url)
  end

  test 'visiting the index' do
    login
    visit product_duplicates_url
    assert_selector 'h1', text: 'Duplications'
  end

  test 'there should not be a New button on the index page' do
    login
    visit product_duplicates_url
    assert_no_selector('#product_duplicates_new')
  end

  test 'there should not be a New button on the index page when nested' do
    login
    visit product_product_duplicates_url(product_id: @product)
    assert_no_selector('#product_duplicates_new')
  end

  test 'index page tabs' do
    login
    visit product_product_duplicates_url(product_id: @product)
    assert_selector("a#tab_product_#{@product.id}_details", text: 'Details')
    assert_selector("a#tab_product_#{@product.id}_product_translations", text: 'Translations')
    assert_selector("a#tab_product_#{@product.id}_product_issues", text: 'Issues')
    assert_selector("a#tab_product_#{@product.id}_product_duplicates", text: 'Duplications')
    assert_selector("a#tab_product_#{@product.id}_audit", text: 'Audit')

    click_on 'Details'
    assert_current_path(product_url(@product))
    click_on 'Translations'
    assert_current_path(product_product_translations_url(product_id: @product))
    click_on 'Issues'
    assert_current_path(product_product_issues_url(product_id: @product))
    click_on 'Duplications'
    assert_current_path(product_product_duplicates_url(product_id: @product))
    click_on 'Audit'
    assert_current_path(product_audits_url(product_id: @product))
  end

  test 'should destroy product duplicate inline' do
    login
    visit product_duplicates_url

    assert_selector("#turbo_stream_product_duplicate_#{@product_duplicate.id}")

    find("#delete_product_duplicate_#{@product_duplicate.id}").click
    find('#confirm_delete').click

    assert_no_selector("#turbo_stream_product_duplicate_#{@product_duplicate.id}")
  end
end
