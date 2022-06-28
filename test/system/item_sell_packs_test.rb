# frozen_string_literal: true

require 'application_system_test_case'

class ItemSellPacksTest < ApplicationSystemTestCase
  setup do
    @item_sell_pack = item_sell_packs(:carton)
  end

  test 'visiting the index' do
    visit item_sell_packs_url
    assert_selector 'h1', text: 'Item Sell Packs'
  end

  test 'automatic paging' do
    visit item_sell_packs_url
    assert_selector("#name_item_sell_pack_#{item_sell_packs(:carton).id}", text: 'carton')
    assert_selector("#name_item_sell_pack_#{item_sell_packs(:each).id}", text: 'each')
    assert_selector("#name_item_sell_pack_#{item_sell_packs(:box).id}", text: 'box')
  end

  test 'should create item sell pack' do
    visit item_sell_packs_url
    click_on 'New item sell pack'

    check 'Canonical' if @item_sell_pack.canonical
    fill_in 'Name', with: "a #{@item_sell_pack.name}"
    click_on 'Create Item sell pack'

    assert_text 'Item sell pack was successfully created'
    click_on 'Back'
  end

  test 'should update Item sell pack' do
    visit item_sell_pack_url(@item_sell_pack)
    click_on 'Edit', match: :first

    fill_in 'Name', with: @item_sell_pack.name
    click_on 'Update'

    assert_text 'Item sell pack was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Item sell pack' do
    visit edit_item_sell_pack_url(@item_sell_pack)
    find("#delete_item_sell_pack_#{@item_sell_pack.id}").click
    find('#confirm_delete').click

    assert_text 'Item sell pack was successfully destroyed'
  end

  test 'should destroy Item sell pack inline' do
    visit item_sell_packs_url

    assert_selector("#turbo_stream_item_sell_pack_#{@item_sell_pack.id}")

    find("#delete_item_sell_pack_#{@item_sell_pack.id}").click
    find('#confirm_delete').click

    assert_no_selector("#turbo_stream_item_sell_pack_#{@item_sell_pack.id}")
  end

  test 'should view Item sell pack' do
    visit item_sell_packs_url
    find("#view_item_sell_pack_#{@item_sell_pack.id}").click
    assert_current_path(item_sell_pack_path(@item_sell_pack))
  end
end
