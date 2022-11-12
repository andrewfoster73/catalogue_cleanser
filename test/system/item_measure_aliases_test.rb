# frozen_string_literal: true

require 'application_system_test_case'

class ItemMeasureAliasesTest < ApplicationSystemTestCase
  setup do
    @item_measure_alias = item_measure_aliases(:one)
  end

  test 'redirects if not logged in' do
    visit item_measure_aliases_url
    assert_current_path(root_url)
  end

  test 'visiting the index' do
    login
    visit item_measure_aliases_url
    assert_selector('h1', text: 'Item Measure Aliases')
    assert_selector('label', text: 'Alias contains')
    assert_selector('input#filter_alias[name="q[alias_cont]"]')
    assert_selector('label', text: 'Confirmed')
    assert_selector('input#q_confirmed_true[name="q[confirmed_true]"]', visible: false)
    assert_selector('input#q_confirmed_not_true[name="q[confirmed_not_true]"]', visible: false)
    assert_selector('button#toggle_confirmed')
  end

  test 'should automatically page' do
    login
    visit item_measure_aliases_url
    assert_selector("#alias_cell_item_measure_alias_#{item_measure_aliases(:one).id}", text: 'one alias')
    assert_selector("#alias_cell_item_measure_alias_#{item_measure_aliases(:two).id}", text: 'two alias')
  end

  test 'inline editing and cancelling' do
    login
    visit item_measure_aliases_url

    # Click to edit
    click_on 'one alias'
    assert_selector("input#item_measure_alias_#{item_measure_aliases(:one).id}_alias")

    # Escape to cancel
    find("input#item_measure_alias_#{item_measure_aliases(:one).id}_alias").send_keys(:escape)
    assert_selector("a[href=\"#{polymorphic_path([:edit, item_measure_aliases(:one)])}\"]", text: 'one alias')

    # Enter to save
    click_on 'one alias'
    find("input#item_measure_alias_#{item_measure_aliases(:one).id}_alias").send_keys('update one alias', :enter)
    assert_selector("a[href=\"#{polymorphic_path([:edit, item_measure_aliases(:one)])}\"]", text: 'update one alias')
  end

  test 'inline editing validation' do
    login
    visit item_measure_aliases_url

    # Click to edit
    click_on 'one alias'
    assert_selector("input#item_measure_alias_#{item_measure_aliases(:one).id}_alias")

    # Set to blank
    find("input#item_measure_alias_#{item_measure_aliases(:one).id}_alias").send_keys(:backspace)
    assert_selector(
      "#item_measure_alias_#{item_measure_aliases(:one).id}_alias--client_side_invalid_message",
      text: 'An alias must be entered'
    )

    # Use a name that already exists
    find("input#item_measure_alias_#{item_measure_aliases(:one).id}_alias").send_keys('another one', :enter)
    assert_selector(
      "#item_measure_alias_#{item_measure_aliases(:one).id}_alias--server_side_invalid_message",
      text: 'Alias has already been taken'
    )
  end

  test 'broadcasting updates to multiple tabs' do
    login
    visit item_measure_aliases_url
    new_window = open_new_window
    within_window new_window do
      visit item_measure_aliases_url
    end

    click_on 'one alias'
    assert_selector("input#item_measure_alias_#{item_measure_aliases(:one).id}_alias")
    find("input#item_measure_alias_#{item_measure_aliases(:one).id}_alias").send_keys('updated one alias', :enter)
    assert_selector("a[href=\"#{polymorphic_path([:edit, item_measure_aliases(:one)])}\"]", text: 'updated one alias')

    within_window new_window do
      assert_selector("a[href=\"#{polymorphic_path([:edit, item_measure_aliases(:one)])}\"]", text: 'updated one alias')
    end
  end

  test 'there should not be a New button on the index page when not nested' do
    login
    visit item_measure_aliases_url
    assert_no_selector('#item_measure_aliases_new')
  end

  test 'should create item measure alias' do
    login
    visit item_measure_item_measure_aliases_url(item_measure_id: item_measures(:one))
    click_on 'New'

    find('#item_measure_alias_new_confirmed--toggle').click
    fill_in 'Alias', with: 'a new alias'
    click_on 'Save'

    assert_selector('a.editable-element', text: 'a new alias')
  end

  test 'should show validation errors on item sell pack alias creation' do
    login
    visit item_measure_item_measure_aliases_url(item_measure_id: item_measures(:one))
    click_on 'New'

    find('#item_measure_alias_new_confirmed--toggle').click
    fill_in 'Alias', with: ''
    assert_selector('#item_measure_alias_new_alias--client_side_invalid_message', text: 'An alias must be entered')
    fill_in 'Alias', with: 'one alias'
    click_on 'Save'

    assert_selector('#item_measure_alias_new_alias--server_side_invalid_message',
                    text: 'alias has already been taken'
                   )
  end

  test 'should update Item measure alias' do
    login
    visit item_measure_alias_url(@item_measure_alias)
    click_on 'Edit', exact: true

    fill_in 'Alias', with: @item_measure_alias.alias
    click_on 'Update'

    assert_text "Item Measure Alias '#{@item_measure_alias}' was successfully updated"
    click_on 'List'
  end

  test 'should show validation errors on item sell pack alias update' do
    login
    visit item_measure_alias_url(@item_measure_alias)
    click_on 'Edit', exact: true

    fill_in 'Alias', with: ''
    assert_selector(
      "#item_measure_alias_#{@item_measure_alias.id}_alias--client_side_invalid_message",
      text: 'An alias must be entered'
    )
    fill_in 'Alias', with: 'another one'
    click_on 'Update'
    assert_selector(
      "#item_measure_alias_#{@item_measure_alias.id}_alias--server_side_invalid_message",
      text: 'Alias has already been taken'
    )
  end

  test 'should destroy Item measure alias' do
    login
    visit edit_item_measure_alias_url(@item_measure_alias)
    find("#delete_item_measure_alias_#{@item_measure_alias.id}").click
    find('#confirm_delete').click

    assert_text "Item Measure Alias '#{@item_measure_alias}' was successfully deleted"
  end

  test 'should destroy Item measure alias inline' do
    login
    visit item_measure_aliases_url

    assert_selector("#turbo_stream_item_measure_alias_#{@item_measure_alias.id}")

    find("#delete_item_measure_alias_#{@item_measure_alias.id}").click
    find('#confirm_delete').click

    assert_no_selector("#turbo_stream_item_measure_alias_#{@item_measure_alias.id}")
  end

  test 'should view Item measure alias' do
    login
    visit item_measure_aliases_url
    find("#view_item_measure_alias_#{@item_measure_alias.id}").click
    assert_current_path(item_measure_alias_path(@item_measure_alias))
  end

  test 'index page tabs' do
    login
    visit item_measure_item_measure_aliases_url(item_measure_id: item_measures(:one))
    assert_selector("a#tab_item_measure_#{item_measures(:one).id}_details", text: 'Details')
    assert_selector("a#tab_item_measure_#{item_measures(:one).id}_item_measure_aliases", text: 'Aliases')
    assert_selector("a#tab_item_measure_#{item_measures(:one).id}_audit", text: 'Audit')

    click_on 'Details'
    assert_current_path(item_measure_url(item_measures(:one).id))
    visit item_measure_item_measure_aliases_url(item_measure_id: item_measures(:one))
    click_on 'Aliases'
    assert_current_path(item_measure_item_measure_aliases_url(item_measure_id: item_measures(:one)))
    click_on 'Audit'
    assert_current_path(item_measure_audits_url(item_measure_id: item_measures(:one)))
  end

  test 'creating and destroying aliases should update badge count' do
    badge_count = item_measures(:one).item_measure_aliases.size
    login
    visit item_measure_item_measure_aliases_url(item_measure_id: item_measures(:one))
    assert_selector(
      "#tab_item_measure_#{item_measures(:one).id}_item_measure_aliases--badge_count__integer",
      text: badge_count
    )

    click_on 'New'
    find('#item_measure_alias_new_confirmed--toggle').click
    fill_in 'Alias', with: 'a new alias'
    click_on 'Save'

    assert_selector(
      "#tab_item_measure_#{item_measures(:one).id}_item_measure_aliases--badge_count__integer",
      text: badge_count + 1
    )

    find('button', text: 'Delete', match: :first).click
    find('#confirm_delete').click
    assert_selector(
      "#tab_item_measure_#{item_measures(:one).id}_item_measure_aliases--badge_count__integer",
      text: badge_count
    )
  end
end
