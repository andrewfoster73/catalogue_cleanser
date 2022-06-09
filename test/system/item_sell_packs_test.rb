# frozen_string_literal: true

require 'application_system_test_case'

class ItemSellPacksTest < ApplicationSystemTestCase
  setup do
    @item_sell_pack = item_sell_packs(:one)
  end

  test 'visiting the index' do
    visit item_sell_packs_url
    assert_selector 'h1', text: 'Item sell packs'
  end

  test 'should create item sell pack' do
    visit item_sell_packs_url
    click_on 'New item sell pack'

    check 'Canonical' if @item_sell_pack.canonical
    fill_in 'Name', with: @item_sell_pack.name
    click_on 'Create Item sell pack'

    assert_text 'Item sell pack was successfully created'
    click_on 'Back'
  end

  test 'should update Item sell pack' do
    visit item_sell_pack_url(@item_sell_pack)
    click_on 'Edit this item sell pack', match: :first

    check 'Canonical' if @item_sell_pack.canonical
    fill_in 'Name', with: @item_sell_pack.name
    click_on 'Update Item sell pack'

    assert_text 'Item sell pack was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Item sell pack' do
    visit item_sell_pack_url(@item_sell_pack)
    click_on 'Destroy this item sell pack', match: :first

    assert_text 'Item sell pack was successfully destroyed'
  end
end
