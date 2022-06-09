# frozen_string_literal: true

require 'test_helper'

class ItemSellPacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item_sell_pack = item_sell_packs(:one)
  end

  test 'should get index' do
    get item_sell_packs_url
    assert_response :success
  end

  test 'should get new' do
    get new_item_sell_pack_url
    assert_response :success
  end

  test 'should create item_sell_pack' do
    assert_difference('ItemSellPack.count') do
      post item_sell_packs_url,
           params: { item_sell_pack: { canonical: @item_sell_pack.canonical, name: @item_sell_pack.name } }
    end

    assert_redirected_to item_sell_pack_url(ItemSellPack.last)
  end

  test 'should show item_sell_pack' do
    get item_sell_pack_url(@item_sell_pack)
    assert_response :success
  end

  test 'should get edit' do
    get edit_item_sell_pack_url(@item_sell_pack)
    assert_response :success
  end

  test 'should update item_sell_pack' do
    patch item_sell_pack_url(@item_sell_pack),
          params: { item_sell_pack: { canonical: @item_sell_pack.canonical, name: @item_sell_pack.name } }
    assert_redirected_to item_sell_pack_url(@item_sell_pack)
  end

  test 'should destroy item_sell_pack' do
    assert_difference('ItemSellPack.count', -1) do
      delete item_sell_pack_url(@item_sell_pack)
    end

    assert_redirected_to item_sell_packs_url
  end
end
