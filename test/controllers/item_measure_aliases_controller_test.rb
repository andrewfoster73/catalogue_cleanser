# frozen_string_literal: true

require 'test_helper'

class ItemMeasureAliasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item_measure_alias = item_measure_aliases(:one)
  end

  test 'should redirect if not authenticated' do
    get item_measure_aliases_url
    assert_redirected_to :root
  end

  test 'should get index' do
    authenticate
    get item_measure_aliases_url
    assert_response :success
  end

  test 'should get new' do
    authenticate
    get new_item_measure_alias_url
    assert_response :success
  end

  test 'should create item_measure_alias' do
    authenticate
    assert_difference('ItemMeasureAlias.count') do
      post item_measure_aliases_url,
           params: {
             item_measure_alias: {
               alias: "an #{@item_measure_alias.alias}",
               confirmed: @item_measure_alias.confirmed,
               item_measure_id: @item_measure_alias.item_measure_id
             }
           }
    end

    assert_redirected_to item_measure_alias_url(ItemMeasureAlias.last, format: :html)
  end

  test 'should show item_measure_alias' do
    authenticate
    get item_measure_alias_url(@item_measure_alias)
    assert_response :success
  end

  test 'should get edit' do
    authenticate
    get edit_item_measure_alias_url(@item_measure_alias)
    assert_response :success
  end

  test 'should update item_measure_alias' do
    authenticate
    patch item_measure_alias_url(@item_measure_alias),
          params: {
            item_measure_alias: {
              alias: @item_measure_alias.alias,
              confirmed: @item_measure_alias.confirmed,
              item_measure_id: @item_measure_alias.item_measure_id
            }
          }
    assert_redirected_to item_measure_alias_url(@item_measure_alias)
  end

  test 'should destroy item_measure_alias' do
    authenticate
    assert_difference('ItemMeasureAlias.count', -1) do
      delete item_measure_alias_url(@item_measure_alias)
    end

    assert_redirected_to item_measure_aliases_url
  end
end
