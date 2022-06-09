# frozen_string_literal: true

require 'application_system_test_case'

class ItemPackAliasesTest < ApplicationSystemTestCase
  setup do
    @item_pack_alias = item_pack_aliases(:one)
  end

  test 'visiting the index' do
    visit item_pack_aliases_url
    assert_selector 'h1', text: 'Item pack aliases'
  end

  test 'should create item pack alias' do
    visit item_pack_aliases_url
    click_on 'New item pack alias'

    fill_in 'Alias', with: @item_pack_alias.alias
    check 'Confirmed' if @item_pack_alias.confirmed
    fill_in 'Item pack', with: @item_pack_alias.item_pack_id
    click_on 'Create Item pack alias'

    assert_text 'Item pack alias was successfully created'
    click_on 'Back'
  end

  test 'should update Item pack alias' do
    visit item_pack_alias_url(@item_pack_alias)
    click_on 'Edit this item pack alias', match: :first

    fill_in 'Alias', with: @item_pack_alias.alias
    check 'Confirmed' if @item_pack_alias.confirmed
    fill_in 'Item pack', with: @item_pack_alias.item_pack_id
    click_on 'Update Item pack alias'

    assert_text 'Item pack alias was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Item pack alias' do
    visit item_pack_alias_url(@item_pack_alias)
    click_on 'Destroy this item pack alias', match: :first

    assert_text 'Item pack alias was successfully destroyed'
  end
end
