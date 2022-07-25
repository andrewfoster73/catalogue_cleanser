# frozen_string_literal: true

require 'test_helper'

class ItemPacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item_pack = item_packs(:one)
  end

  test 'should redirect if not authenticated' do
    get item_packs_url
    assert_redirected_to :root
  end

  test 'should get index' do
    authenticate
    get item_packs_url
    assert_response :success
  end

  test 'should get new' do
    authenticate
    get new_item_pack_url
    assert_response :success
  end

  test 'should create item_pack' do
    authenticate
    assert_difference('ItemPack.count') do
      post item_packs_url, params: { item_pack: { canonical: @item_pack.canonical, name: "a #{@item_pack.name}" } }
    end

    assert_redirected_to item_pack_url(ItemPack.last, format: :html)
  end

  test 'should show item_pack' do
    authenticate
    get item_pack_url(@item_pack)
    assert_response :success
  end

  test 'should get edit' do
    authenticate
    get edit_item_pack_url(@item_pack)
    assert_response :success
  end

  test 'should update item_pack' do
    authenticate
    patch item_pack_url(@item_pack), params: { item_pack: { canonical: @item_pack.canonical, name: @item_pack.name } }
    assert_redirected_to item_pack_url(@item_pack)
  end

  test 'should destroy item_pack' do
    authenticate
    assert_difference('ItemPack.count', -1) do
      delete item_pack_url(@item_pack)
    end

    assert_redirected_to item_packs_url
  end
end
