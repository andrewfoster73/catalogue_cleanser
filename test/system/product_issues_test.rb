# frozen_string_literal: true

require 'application_system_test_case'

class ProductIssuesTest < ApplicationSystemTestCase
  setup do
    @product = products(:lager)
    @product_issue = product_issues(:missing_compulsory)
  end

  test 'redirects if not logged in' do
    visit product_product_issues_url(product_id: @product)
    assert_current_path(root_url)
  end

  test 'visiting the index' do
    login
    visit product_product_issues_url(product_id: @product)
    assert_selector 'h1', text: 'Issues'
  end

  test 'there should not be a New button on the index page' do
    login
    visit product_issues_url
    assert_no_selector('#product_issues_new')
  end

  test 'there should not be a New button on the index page when nested' do
    login
    visit product_product_issues_url(product_id: @product)
    assert_no_selector('#product_issues_new')
  end

  test 'index page tabs' do
    login
    visit product_product_issues_url(product_id: @product)
    assert_selector("a#tab_product_#{@product.id}_details", text: 'Details')
    assert_selector("a#tab_product_#{@product.id}_product_translations", text: 'Translations')
    assert_selector("a#tab_product_#{@product.id}_product_issues", text: 'Issues')
    assert_selector("a#tab_product_#{@product.id}_audit", text: 'Audit')

    click_on 'Details'
    assert_current_path(product_url(@product))
    click_on 'Translations'
    assert_current_path(product_product_translations_url(product_id: @product))
    click_on 'Issues'
    assert_current_path(product_product_issues_url(product_id: @product))
    click_on 'Audit'
    assert_current_path(product_audits_url(product_id: @product))
  end

  test 'should destroy product issue inline' do
    login
    visit product_issues_url

    assert_selector("#turbo_stream_product_issue_#{@product_issue.id}")

    find("#delete_product_issue_#{@product_issue.id}").click
    find('#confirm_delete').click

    assert_no_selector("#turbo_stream_product_issue_#{@product_issue.id}")
  end
end
