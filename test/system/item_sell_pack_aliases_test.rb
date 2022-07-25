# frozen_string_literal: true

require 'application_system_test_case'

class ItemSellPackAliasesTest < ApplicationSystemTestCase
  setup do
    @item_sell_pack_alias = item_sell_pack_aliases(:ctn)
  end

  test 'redirects if not logged in' do
    visit item_sell_pack_aliases_url
    assert_current_path(root_url)
  end

  test 'visiting the index' do
    login
    visit item_sell_pack_aliases_url
    assert_selector 'h1', text: 'Item sell pack aliases'
  end

  test 'should create item sell pack alias' do
    login
    visit item_sell_pack_aliases_url
    click_on 'New item sell pack alias'

    fill_in 'Alias', with: "an #{@item_sell_pack_alias.alias}"
    check 'Confirmed' if @item_sell_pack_alias.confirmed
    fill_in 'Item sell pack', with: @item_sell_pack_alias.item_sell_pack_id
    click_on 'Create Item sell pack alias'

    assert_text "Item sell pack alias 'an #{@item_sell_pack_alias}' was successfully created"
    click_on 'Back'
  end

  test 'should update Item sell pack alias' do
    login
    visit item_sell_pack_alias_url(@item_sell_pack_alias)
    click_on 'Edit this item sell pack alias', match: :first

    fill_in 'Alias', with: @item_sell_pack_alias.alias
    check 'Confirmed' if @item_sell_pack_alias.confirmed
    fill_in 'Item sell pack', with: @item_sell_pack_alias.item_sell_pack_id
    click_on 'Update Item sell pack alias'

    assert_text "Item sell pack alias '#{@item_sell_pack_alias}' was successfully updated"
    click_on 'Back'
  end

  test 'should destroy Item sell pack alias' do
    login
    visit item_sell_pack_alias_url(@item_sell_pack_alias)
    click_on 'Destroy this item sell pack alias', match: :first

    assert_text "Item sell pack alias '#{@item_sell_pack_alias}' was successfully deleted"
  end
end
