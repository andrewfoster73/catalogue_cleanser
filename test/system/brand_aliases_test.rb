# frozen_string_literal: true

require 'application_system_test_case'

class BrandAliasesTest < ApplicationSystemTestCase
  setup do
    @brand_alias = brand_aliases(:one)
  end

  test 'redirects if not logged in' do
    visit brand_aliases_url
    assert_current_path(root_url)
  end

  test 'visiting the index' do
    login
    visit brand_aliases_url
    assert_selector 'h1', text: 'Brand aliases'
  end

  test 'should create brand alias' do
    login
    visit brand_aliases_url
    click_on 'New brand alias'

    fill_in 'Alias', with: "an #{@brand_alias.alias}"
    fill_in 'Brand', with: @brand_alias.brand_id
    check 'Confirmed' if @brand_alias.confirmed
    fill_in 'Count', with: @brand_alias.count
    click_on 'Create Brand alias'

    assert_text "Brand alias 'an #{@brand_alias}' was successfully created"
    click_on 'Back'
  end

  test 'should update Brand alias' do
    login
    visit brand_alias_url(@brand_alias)
    click_on 'Edit this brand alias', match: :first

    fill_in 'Alias', with: @brand_alias.alias
    fill_in 'Brand', with: @brand_alias.brand_id
    check 'Confirmed' if @brand_alias.confirmed
    fill_in 'Count', with: @brand_alias.count
    click_on 'Update Brand alias'

    assert_text "Brand alias '#{@brand_alias}' was successfully updated"
    click_on 'Back'
  end

  test 'should destroy Brand alias' do
    login
    visit brand_alias_url(@brand_alias)
    click_on 'Destroy this brand alias', match: :first

    assert_text "Brand alias '#{@brand_alias}' was successfully deleted"
  end
end
