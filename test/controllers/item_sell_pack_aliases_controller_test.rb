# frozen_string_literal: true

require 'test_helper'

class ItemSellPackAliasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item_sell_pack_alias = item_sell_pack_aliases(:ctn)
  end

  test 'should get index' do
    get item_sell_pack_aliases_url
    assert_response :success
  end

  test 'should get new' do
    get new_item_sell_pack_alias_url
    assert_response :success
  end

  test 'should create item_sell_pack_alias' do
    assert_difference('ItemSellPackAlias.count') do
      post item_sell_pack_aliases_url,
           params: {
             item_sell_pack_alias: {
               alias: "an #{@item_sell_pack_alias.alias}",
               confirmed: @item_sell_pack_alias.confirmed,
               item_sell_pack_id: @item_sell_pack_alias.item_sell_pack_id
             }
           }
    end

    assert_redirected_to item_sell_pack_alias_url(ItemSellPackAlias.last, format: :html)
  end

  test 'should show item_sell_pack_alias' do
    get item_sell_pack_alias_url(@item_sell_pack_alias)
    assert_response :success
  end

  test 'should get edit' do
    get edit_item_sell_pack_alias_url(@item_sell_pack_alias)
    assert_response :success
  end

  test 'should update item_sell_pack_alias' do
    patch item_sell_pack_alias_url(@item_sell_pack_alias),
          params: {
            item_sell_pack_alias: {
              alias: @item_sell_pack_alias.alias,
              confirmed: @item_sell_pack_alias.confirmed,
              item_sell_pack_id: @item_sell_pack_alias.item_sell_pack_id
            }
          }
    assert_redirected_to item_sell_pack_alias_url(@item_sell_pack_alias)
  end

  test 'should destroy item_sell_pack_alias' do
    assert_difference('ItemSellPackAlias.count', -1) do
      delete item_sell_pack_alias_url(@item_sell_pack_alias)
    end

    assert_redirected_to item_sell_pack_aliases_url
  end
end
