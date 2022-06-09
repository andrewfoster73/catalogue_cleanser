# frozen_string_literal: true

require 'test_helper'

class BrandAliasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @brand_alias = brand_aliases(:one)
  end

  test 'should get index' do
    get brand_aliases_url
    assert_response :success
  end

  test 'should get new' do
    get new_brand_alias_url
    assert_response :success
  end

  test 'should create brand_alias' do
    assert_difference('BrandAlias.count') do
      post brand_aliases_url,
           params: {
             brand_alias: {
               alias: @brand_alias.alias,
               brand_id: @brand_alias.brand_id,
               confirmed: @brand_alias.confirmed,
               count: @brand_alias.count
             }
           }
    end

    assert_redirected_to brand_alias_url(BrandAlias.last)
  end

  test 'should show brand_alias' do
    get brand_alias_url(@brand_alias)
    assert_response :success
  end

  test 'should get edit' do
    get edit_brand_alias_url(@brand_alias)
    assert_response :success
  end

  test 'should update brand_alias' do
    patch brand_alias_url(@brand_alias),
          params: {
            brand_alias: {
              alias: @brand_alias.alias,
              brand_id: @brand_alias.brand_id,
              confirmed: @brand_alias.confirmed,
              count: @brand_alias.count
            }
          }
    assert_redirected_to brand_alias_url(@brand_alias)
  end

  test 'should destroy brand_alias' do
    assert_difference('BrandAlias.count', -1) do
      delete brand_alias_url(@brand_alias)
    end

    assert_redirected_to brand_aliases_url
  end
end
