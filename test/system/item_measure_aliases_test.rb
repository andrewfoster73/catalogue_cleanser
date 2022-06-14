# frozen_string_literal: true

require 'application_system_test_case'

class ItemMeasureAliasesTest < ApplicationSystemTestCase
  setup do
    @item_measure_alias = item_measure_aliases(:one)
  end

  test 'visiting the index' do
    visit item_measure_aliases_url
    assert_selector 'h1', text: 'Item measure aliases'
  end

  test 'should create item measure alias' do
    visit item_measure_aliases_url
    click_on 'New item measure alias'

    fill_in 'Alias', with: "an #{@item_measure_alias.alias}"
    check 'Confirmed' if @item_measure_alias.confirmed
    fill_in 'Item measure', with: @item_measure_alias.item_measure_id
    click_on 'Create Item measure alias'

    assert_text 'Item measure alias was successfully created'
    click_on 'Back'
  end

  test 'should update Item measure alias' do
    visit item_measure_alias_url(@item_measure_alias)
    click_on 'Edit this item measure alias', match: :first

    fill_in 'Alias', with: @item_measure_alias.alias
    check 'Confirmed' if @item_measure_alias.confirmed
    fill_in 'Item measure', with: @item_measure_alias.item_measure_id
    click_on 'Update Item measure alias'

    assert_text 'Item measure alias was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Item measure alias' do
    visit item_measure_alias_url(@item_measure_alias)
    click_on 'Destroy this item measure alias', match: :first

    assert_text 'Item measure alias was successfully destroyed'
  end
end
