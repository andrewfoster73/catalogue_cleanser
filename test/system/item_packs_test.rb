# frozen_string_literal: true

require 'application_system_test_case'

class ItemPacksTest < ApplicationSystemTestCase
  setup do
    @item_pack = item_packs(:one)
  end

  test 'visiting the index' do
    visit item_packs_url
    assert_selector 'h1', text: 'Item packs'
  end

  test 'should create item pack' do
    visit item_packs_url
    click_on 'New item pack'

    check 'Canonical' if @item_pack.canonical
    fill_in 'Name', with: @item_pack.name
    click_on 'Create Item pack'

    assert_text 'Item pack was successfully created'
    click_on 'Back'
  end

  test 'should update Item pack' do
    visit item_pack_url(@item_pack)
    click_on 'Edit this item pack', match: :first

    check 'Canonical' if @item_pack.canonical
    fill_in 'Name', with: @item_pack.name
    click_on 'Update Item pack'

    assert_text 'Item pack was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Item pack' do
    visit item_pack_url(@item_pack)
    click_on 'Destroy this item pack', match: :first

    assert_text 'Item pack was successfully destroyed'
  end
end
