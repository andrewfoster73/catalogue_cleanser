# frozen_string_literal: true

require 'application_system_test_case'

class ItemMeasuresTest < ApplicationSystemTestCase
  setup do
    @item_measure = item_measures(:one)
  end

  test 'visiting the index' do
    visit item_measures_url
    assert_selector 'h1', text: 'Item measures'
  end

  test 'should create item measure' do
    visit item_measures_url
    click_on 'New item measure'

    check 'Canonical' if @item_measure.canonical
    fill_in 'Name', with: @item_measure.name
    click_on 'Create Item measure'

    assert_text 'Item measure was successfully created'
    click_on 'Back'
  end

  test 'should update Item measure' do
    visit item_measure_url(@item_measure)
    click_on 'Edit this item measure', match: :first

    check 'Canonical' if @item_measure.canonical
    fill_in 'Name', with: @item_measure.name
    click_on 'Update Item measure'

    assert_text 'Item measure was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Item measure' do
    visit item_measure_url(@item_measure)
    click_on 'Destroy this item measure', match: :first

    assert_text 'Item measure was successfully destroyed'
  end
end
