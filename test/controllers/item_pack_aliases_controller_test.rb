# frozen_string_literal: true

require 'test_helper'

class ItemPackAliasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item_pack_alias = item_pack_aliases(:one)
  end

  test 'should redirect if not authenticated' do
    get item_pack_aliases_url
    assert_redirected_to :root
  end

  test 'should get index' do
    authenticate
    get item_pack_aliases_url
    assert_response :success
  end

  test 'should get new' do
    authenticate
    get new_item_pack_alias_url
    assert_response :success
  end

  test 'should create item_pack_alias' do
    authenticate
    assert_difference('ItemPackAlias.count') do
      post item_pack_aliases_url,
           params: {
             item_pack_alias: {
               alias: "an #{@item_pack_alias.alias}",
               confirmed: @item_pack_alias.confirmed,
               item_pack_id: @item_pack_alias.item_pack_id
             }
           }
    end

    assert_redirected_to item_pack_alias_url(ItemPackAlias.last, format: :html)
  end

  test 'should show item_pack_alias' do
    authenticate
    get item_pack_alias_url(@item_pack_alias)
    assert_response :success
  end

  test 'should get edit' do
    authenticate
    get edit_item_pack_alias_url(@item_pack_alias)
    assert_response :success
  end

  test 'should update item_pack_alias' do
    authenticate
    patch item_pack_alias_url(@item_pack_alias),
          params: {
            item_pack_alias: {
              alias: @item_pack_alias.alias,
              confirmed: @item_pack_alias.confirmed,
              item_pack_id: @item_pack_alias.item_pack_id
            }
          }
    assert_redirected_to item_pack_alias_url(@item_pack_alias)
  end

  test 'should destroy item_pack_alias' do
    authenticate
    assert_difference('ItemPackAlias.count', -1) do
      delete item_pack_alias_url(@item_pack_alias)
    end

    assert_redirected_to item_pack_aliases_url
  end
end
