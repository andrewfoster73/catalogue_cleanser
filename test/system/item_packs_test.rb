# frozen_string_literal: true

require 'application_system_test_case'

class ItemPacksTest < ApplicationSystemTestCase
  setup do
    @item_pack = item_packs(:one)
  end

  test 'redirects if not logged in' do
    visit item_packs_url
    assert_current_path(root_url)
  end

  test 'visiting the index' do
    login
    visit item_packs_url
    assert_selector 'h1', text: 'Item packs'
  end

  test 'should create item pack' do
    login
    visit item_packs_url
    click_on 'New item pack'

    check 'Canonical' if @item_pack.canonical
    fill_in 'Name', with: "a #{@item_pack.name}"
    click_on 'Create Item pack'

    assert_text "Item pack 'a #{@item_pack}' was successfully created"
    click_on 'Back'
  end

  test 'should update Item pack' do
    login
    visit item_pack_url(@item_pack)
    click_on 'Edit this item pack', match: :first

    check 'Canonical' if @item_pack.canonical
    fill_in 'Name', with: @item_pack.name
    click_on 'Update Item pack'

    assert_text "Item pack '#{@item_pack}' was successfully updated"
    click_on 'Back'
  end

  test 'should destroy Item pack' do
    login
    visit item_pack_url(@item_pack)
    click_on 'Destroy this item pack', match: :first

    assert_text "Item pack '#{@item_pack}' was successfully deleted"
  end
end
