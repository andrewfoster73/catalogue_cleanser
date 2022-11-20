# frozen_string_literal: true

require 'application_system_test_case'

class ItemPackAliasesTest < ApplicationSystemTestCase
  setup do
    @item_pack_alias = item_pack_aliases(:ctn)
  end

  test 'redirects if not logged in' do
    visit item_pack_aliases_url
    assert_current_path(root_url)
  end

  test 'visiting the index' do
    login
    visit item_pack_aliases_url
    assert_selector('h1', text: 'Item Pack Aliases')
    assert_selector('label', text: 'Alias contains')
    assert_selector('input#filter_alias[name="q[alias_cont]"]')
    assert_selector('label', text: 'Confirmed')
    assert_selector('input#q_confirmed_true[name="q[confirmed_true]"]', visible: false)
    assert_selector('input#q_confirmed_not_true[name="q[confirmed_not_true]"]', visible: false)
    assert_selector('button#toggle_confirmed')
  end

  test 'should automatically page' do
    login
    visit item_pack_aliases_url
    assert_selector("#alias_cell_item_pack_alias_#{item_pack_aliases(:ctn).id}", text: 'ctn')
    assert_selector("#alias_cell_item_pack_alias_#{item_pack_aliases(:ea).id}", text: 'ea')
  end

  test 'inline editing and cancelling' do
    login
    visit item_pack_aliases_url

    # Click to edit
    click_on 'ctn'
    assert_selector("input#item_pack_alias_#{item_pack_aliases(:ctn).id}_alias")

    # Escape to cancel
    find("input#item_pack_alias_#{item_pack_aliases(:ctn).id}_alias").send_keys(:escape)
    assert_selector("a[href=\"#{polymorphic_path([:edit, item_pack_aliases(:ctn)])}\"]", text: 'ctn')

    # Enter to save
    click_on 'ctn'
    find("input#item_pack_alias_#{item_pack_aliases(:ctn).id}_alias").send_keys('cart', :enter)
    assert_selector("a[href=\"#{polymorphic_path([:edit, item_pack_aliases(:ctn)])}\"]", text: 'cart')
  end

  test 'inline editing validation' do
    login
    visit item_pack_aliases_url

    # Click to edit
    click_on 'ctn'
    assert_selector("input#item_pack_alias_#{item_pack_aliases(:ctn).id}_alias")

    # Set to blank
    find("input#item_pack_alias_#{item_pack_aliases(:ctn).id}_alias").send_keys(:backspace)
    assert_selector(
      "#item_pack_alias_#{item_pack_aliases(:ctn).id}_alias--client_side_invalid_message",
      text: 'An alias must be entered'
    )

    # Use a name that already exists
    find("input#item_pack_alias_#{item_pack_aliases(:ctn).id}_alias").send_keys('ct', :enter)
    assert_selector(
      "#item_pack_alias_#{item_pack_aliases(:ctn).id}_alias--server_side_invalid_message",
      text: 'Alias has already been taken'
    )
  end

  test 'broadcasting updates to multiple tabs' do
    login
    visit item_pack_aliases_url
    new_window = open_new_window
    within_window new_window do
      visit item_pack_aliases_url
    end

    click_on 'ctn'
    assert_selector("input#item_pack_alias_#{item_pack_aliases(:ctn).id}_alias")
    find("input#item_pack_alias_#{item_pack_aliases(:ctn).id}_alias").send_keys('cart', :enter)
    assert_selector("a[href=\"#{polymorphic_path([:edit, item_pack_aliases(:ctn)])}\"]", text: 'cart')

    within_window new_window do
      assert_selector("a[href=\"#{polymorphic_path([:edit, item_pack_aliases(:ctn)])}\"]", text: 'cart')
    end
  end

  test 'there should not be a New button on the index page when not nested' do
    login
    visit item_pack_aliases_url
    assert_no_selector('#item_pack_aliases_new')
  end

  test 'should create item pack alias' do
    login
    visit item_pack_item_pack_aliases_url(item_pack_id: item_packs(:carton))
    click_on 'New'

    find('#item_pack_alias_new_confirmed--toggle').click
    fill_in 'Alias', with: 'a new alias'
    click_on 'Save'

    assert_selector('a.editable-element', text: 'a new alias')
  end

  test 'should show validation errors on item pack alias creation' do
    login
    visit item_pack_item_pack_aliases_url(item_pack_id: item_packs(:carton))
    click_on 'New'

    find('#item_pack_alias_new_confirmed--toggle').click
    fill_in 'Alias', with: ''
    assert_selector('#item_pack_alias_new_alias--client_side_invalid_message', text: 'An alias must be entered')
    fill_in 'Alias', with: 'ctn'
    click_on 'Save'

    assert_selector('#item_pack_alias_new_alias--server_side_invalid_message',
                    text: 'alias has already been taken'
                   )
  end

  test 'should update Item pack alias' do
    login
    visit item_pack_alias_url(@item_pack_alias)
    click_on 'Edit', exact: true

    fill_in 'Alias', with: @item_pack_alias.alias
    click_on 'Update'

    assert_text "Item Pack Alias '#{@item_pack_alias}' was successfully updated"
    click_on 'List'
  end

  test 'should show validation errors on item pack alias update' do
    login
    visit item_pack_alias_url(@item_pack_alias)
    click_on 'Edit', exact: true

    fill_in 'Alias', with: ''
    assert_selector(
      "#item_pack_alias_#{@item_pack_alias.id}_alias--client_side_invalid_message",
      text: 'An alias must be entered'
    )
    fill_in 'Alias', with: 'ct'
    click_on 'Update'
    assert_selector(
      "#item_pack_alias_#{@item_pack_alias.id}_alias--server_side_invalid_message",
      text: 'Alias has already been taken'
    )
  end

  test 'should destroy Item pack alias' do
    login
    visit edit_item_pack_alias_url(@item_pack_alias)
    find("#delete_item_pack_alias_#{@item_pack_alias.id}").click
    find('#confirm_delete').click

    assert_text "Item Pack Alias '#{@item_pack_alias}' was successfully deleted"
  end

  test 'should destroy Item pack alias inline' do
    login
    visit item_pack_aliases_url

    assert_selector("#turbo_stream_item_pack_alias_#{@item_pack_alias.id}")

    find("#delete_item_pack_alias_#{@item_pack_alias.id}").click
    find('#confirm_delete').click

    assert_no_selector("#turbo_stream_item_pack_alias_#{@item_pack_alias.id}")
  end

  test 'should view Item pack alias' do
    login
    visit item_pack_aliases_url
    find("#view_item_pack_alias_#{@item_pack_alias.id}").click
    assert_current_path(item_pack_alias_path(@item_pack_alias))
  end

  test 'index page tabs' do
    login
    visit item_pack_item_pack_aliases_url(item_pack_id: item_packs(:carton))
    assert_selector("a#tab_item_pack_#{item_packs(:carton).id}_details", text: 'Details')
    assert_selector("a#tab_item_pack_#{item_packs(:carton).id}_item_pack_aliases", text: 'Aliases')
    assert_selector("a#tab_item_pack_#{item_packs(:carton).id}_audit", text: 'Audit')

    click_on 'Details'
    assert_current_path(item_pack_url(item_packs(:carton).id))
    visit item_pack_item_pack_aliases_url(item_pack_id: item_packs(:carton))
    click_on 'Aliases'
    assert_current_path(item_pack_item_pack_aliases_url(item_pack_id: item_packs(:carton)))
    click_on 'Audit'
    assert_current_path(item_pack_audits_url(item_pack_id: item_packs(:carton)))
  end

  test 'creating and destroying aliases should update badge count' do
    badge_count = item_packs(:carton).item_pack_aliases.size
    login
    visit item_pack_item_pack_aliases_url(item_pack_id: item_packs(:carton))
    assert_selector(
      "#tab_item_pack_#{item_packs(:carton).id}_item_pack_aliases--badge_count__integer",
      text: badge_count
    )

    click_on 'New'
    find('#item_pack_alias_new_confirmed--toggle').click
    fill_in 'Alias', with: 'a new alias'
    click_on 'Save'

    assert_selector(
      "#tab_item_pack_#{item_packs(:carton).id}_item_pack_aliases--badge_count__integer",
      text: badge_count + 1
    )

    find('button', text: 'Delete', match: :first).click
    find('#confirm_delete').click
    assert_selector(
      "#tab_item_pack_#{item_packs(:carton).id}_item_pack_aliases--badge_count__integer",
      text: badge_count
    )
  end
end
