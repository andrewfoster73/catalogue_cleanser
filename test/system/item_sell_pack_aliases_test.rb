# frozen_string_literal: true

require 'application_system_test_case'

# rubocop:disable Metrics/ClassLength
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
    assert_selector 'h1', text: 'Item Sell Pack Aliases'
  end

  test 'should automatically page' do
    login
    visit item_sell_pack_aliases_url
    assert_selector("#alias_cell_item_sell_pack_alias_#{item_sell_pack_aliases(:ctn).id}", text: 'ctn')
    assert_selector("#alias_cell_item_sell_pack_alias_#{item_sell_pack_aliases(:ea).id}", text: 'ea')
  end

  test 'inline editing and cancelling' do
    login
    visit item_sell_pack_aliases_url

    # Click to edit
    click_on 'ctn'
    assert_selector("input#item_sell_pack_alias_#{item_sell_pack_aliases(:ctn).id}_alias")

    # Escape to cancel
    find("input#item_sell_pack_alias_#{item_sell_pack_aliases(:ctn).id}_alias").send_keys(:escape)
    assert_selector("a[href=\"#{polymorphic_path([:edit, item_sell_pack_aliases(:ctn)])}\"]", text: 'ctn')

    # Enter to save
    click_on 'ctn'
    find("input#item_sell_pack_alias_#{item_sell_pack_aliases(:ctn).id}_alias").send_keys('cart', :enter)
    assert_selector("a[href=\"#{polymorphic_path([:edit, item_sell_pack_aliases(:ctn)])}\"]", text: 'cart')
  end

  test 'inline editing validation' do
    login
    visit item_sell_pack_aliases_url

    # Click to edit
    click_on 'ctn'
    assert_selector("input#item_sell_pack_alias_#{item_sell_pack_aliases(:ctn).id}_alias")

    # Set to blank
    find("input#item_sell_pack_alias_#{item_sell_pack_aliases(:ctn).id}_alias").send_keys(:backspace)
    assert_selector(
      "#item_sell_pack_alias_#{item_sell_pack_aliases(:ctn).id}_alias--client_side_invalid_message",
      text: 'An alias must be entered'
    )

    # Use a name that already exists
    find("input#item_sell_pack_alias_#{item_sell_pack_aliases(:ctn).id}_alias").send_keys('ct', :enter)
    assert_selector(
      "#item_sell_pack_alias_#{item_sell_pack_aliases(:ctn).id}_alias--server_side_invalid_message",
      text: 'Alias has already been taken'
    )
  end

  test 'broadcasting updates to multiple tabs' do
    login
    visit item_sell_pack_aliases_url
    new_window = open_new_window
    within_window new_window do
      visit item_sell_pack_aliases_url
    end

    click_on 'ctn'
    assert_selector("input#item_sell_pack_alias_#{item_sell_pack_aliases(:ctn).id}_alias")
    find("input#item_sell_pack_alias_#{item_sell_pack_aliases(:ctn).id}_alias").send_keys('cart', :enter)
    assert_selector("a[href=\"#{polymorphic_path([:edit, item_sell_pack_aliases(:ctn)])}\"]", text: 'cart')

    within_window new_window do
      assert_selector("a[href=\"#{polymorphic_path([:edit, item_sell_pack_aliases(:ctn)])}\"]", text: 'cart')
    end
  end

  test 'there should not be a New button on the index page when not nested' do
    login
    visit item_sell_pack_aliases_url
    assert_no_selector('#item_sell_pack_aliases_new')
  end

  test 'should create item sell pack alias' do
    login
    visit item_sell_pack_item_sell_pack_aliases_url(item_sell_pack_id: item_sell_packs(:carton))
    click_on 'New'

    find('#item_sell_pack_alias_new_confirmed--toggle').click
    fill_in 'Alias', with: 'a new alias'
    click_on 'Save'

    assert_selector('a.editable-element', text: 'a new alias')
  end

  test 'should show validation errors on item sell pack alias creation' do
    login
    visit item_sell_pack_item_sell_pack_aliases_url(item_sell_pack_id: item_sell_packs(:carton))
    click_on 'New'

    find('#item_sell_pack_alias_new_confirmed--toggle').click
    fill_in 'Alias', with: ''
    assert_selector('#item_sell_pack_alias_new_alias--client_side_invalid_message', text: 'An alias must be entered')
    fill_in 'Alias', with: 'ctn'
    click_on 'Save'

    assert_selector('#item_sell_pack_alias_new_alias--server_side_invalid_message',
                    text: 'alias has already been taken'
                   )
  end

  test 'should update Item sell pack alias' do
    login
    visit item_sell_pack_alias_url(@item_sell_pack_alias)
    click_on 'Edit', match: :first

    fill_in 'Alias', with: @item_sell_pack_alias.alias
    click_on 'Update'

    assert_text "Item sell pack alias '#{@item_sell_pack_alias}' was successfully updated"
    click_on 'List'
  end

  test 'should show validation errors on item sell pack alias update' do
    login
    visit item_sell_pack_alias_url(@item_sell_pack_alias)
    click_on 'Edit', match: :first

    fill_in 'Alias', with: ''
    assert_selector(
      "#item_sell_pack_alias_#{@item_sell_pack_alias.id}_alias--client_side_invalid_message",
      text: 'An alias must be entered'
    )
    fill_in 'Alias', with: 'ct'
    click_on 'Update'
    assert_selector(
      "#item_sell_pack_alias_#{@item_sell_pack_alias.id}_alias--server_side_invalid_message",
      text: 'Alias has already been taken'
    )
  end

  test 'should destroy Item sell pack' do
    login
    visit edit_item_sell_pack_alias_url(@item_sell_pack_alias)
    find("#delete_item_sell_pack_alias_#{@item_sell_pack_alias.id}").click
    find('#confirm_delete').click

    assert_text "Item sell pack alias '#{@item_sell_pack_alias}' was successfully deleted"
  end

  test 'should destroy Item sell pack alias inline' do
    login
    visit item_sell_pack_aliases_url

    assert_selector("#turbo_stream_item_sell_pack_alias_#{@item_sell_pack_alias.id}")

    find("#delete_item_sell_pack_alias_#{@item_sell_pack_alias.id}").click
    find('#confirm_delete').click

    assert_no_selector("#turbo_stream_item_sell_pack_alias_#{@item_sell_pack_alias.id}")
  end

  test 'should view Item sell pack alias' do
    login
    visit item_sell_pack_aliases_url
    find("#view_item_sell_pack_alias_#{@item_sell_pack_alias.id}").click
    assert_current_path(item_sell_pack_alias_path(@item_sell_pack_alias))
  end

  test 'index page tabs' do
    login
    visit item_sell_pack_item_sell_pack_aliases_url(item_sell_pack_id: item_sell_packs(:carton))
    assert_selector("a#tab_item_sell_pack_#{item_sell_packs(:carton).id}_details", text: 'Details')
    assert_selector("a#tab_item_sell_pack_#{item_sell_packs(:carton).id}_item_sell_pack_aliases", text: 'Aliases')
    assert_selector("a#tab_item_sell_pack_#{item_sell_packs(:carton).id}_audit", text: 'Audit')

    click_on 'Details'
    assert_current_path(edit_item_sell_pack_url(item_sell_packs(:carton).id))
    visit item_sell_pack_item_sell_pack_aliases_url(item_sell_pack_id: item_sell_packs(:carton))
    click_on 'Aliases'
    assert_current_path(item_sell_pack_item_sell_pack_aliases_url(item_sell_pack_id: item_sell_packs(:carton)))
  end

  test 'creating and destroying aliases should update badge count' do
    badge_count = item_sell_packs(:carton).item_sell_pack_aliases.size
    login
    visit item_sell_pack_item_sell_pack_aliases_url(item_sell_pack_id: item_sell_packs(:carton))
    assert_selector(
      "#tab_item_sell_pack_#{item_sell_packs(:carton).id}_item_sell_pack_aliases--badge_count__integer",
      text: badge_count
    )

    click_on 'New'
    find('#item_sell_pack_alias_new_confirmed--toggle').click
    fill_in 'Alias', with: 'a new alias'
    click_on 'Save'

    assert_selector(
      "#tab_item_sell_pack_#{item_sell_packs(:carton).id}_item_sell_pack_aliases--badge_count__integer",
      text: badge_count + 1
    )

    find('button', text: 'Delete', match: :first).click
    find('#confirm_delete').click
    assert_selector(
      "#tab_item_sell_pack_#{item_sell_packs(:carton).id}_item_sell_pack_aliases--badge_count__integer",
      text: badge_count
    )
  end
end
# rubocop:enable Metrics/ClassLength
