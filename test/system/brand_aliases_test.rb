# frozen_string_literal: true

require 'application_system_test_case'

class BrandAliasesTest < ApplicationSystemTestCase
  setup do
    @brand_alias = brand_aliases(:one)
  end

  test 'redirects if not logged in' do
    visit brand_aliases_url
    assert_current_path(root_url)
  end

  test 'visiting the index' do
    login
    visit brand_aliases_url
    assert_selector('h1', text: 'Brand Aliases')
    assert_selector('label', text: 'Alias contains')
    assert_selector('input#filter_alias[name="q[alias_cont]"]')
    assert_selector('label', text: 'Confirmed')
    assert_selector('input#q_confirmed_true[name="q[confirmed_true]"]', visible: false)
    assert_selector('input#q_confirmed_not_true[name="q[confirmed_not_true]"]', visible: false)
    assert_selector('button#toggle_confirmed')
  end

  test 'should automatically page' do
    login
    visit brand_aliases_url
    assert_selector("#alias_cell_brand_alias_#{brand_aliases(:one).id}", text: 'one alias')
    assert_selector("#alias_cell_brand_alias_#{brand_aliases(:two).id}", text: 'another one')
  end

  test 'inline editing and cancelling' do
    login
    visit brand_aliases_url

    # Click to edit
    click_on 'one alias'
    assert_selector("input#brand_alias_#{brand_aliases(:one).id}_alias")

    # Escape to cancel
    find("input#brand_alias_#{brand_aliases(:one).id}_alias").send_keys(:escape)
    assert_selector("a[href=\"#{polymorphic_path([:edit, brand_aliases(:one)])}\"]", text: 'one alias')

    # Enter to save
    click_on 'one alias'
    find("input#brand_alias_#{brand_aliases(:one).id}_alias").send_keys('different one alias', :enter)
    assert_selector("a[href=\"#{polymorphic_path([:edit, brand_aliases(:one)])}\"]", text: 'different one alias')
  end

  test 'inline editing validation' do
    login
    visit brand_aliases_url

    # Click to edit
    click_on 'one alias'
    assert_selector("input#brand_alias_#{brand_aliases(:one).id}_alias")

    # Set to blank
    find("input#brand_alias_#{brand_aliases(:one).id}_alias").send_keys(:backspace)
    assert_selector(
      "#brand_alias_#{brand_aliases(:one).id}_alias--client_side_invalid_message",
      text: 'An alias must be entered'
    )

    # Use a name that already exists
    find("input#brand_alias_#{brand_aliases(:one).id}_alias").send_keys('another one', :enter)
    assert_selector(
      "#brand_alias_#{brand_aliases(:one).id}_alias--server_side_invalid_message",
      text: 'Alias has already been taken'
    )
  end

  test 'broadcasting updates to multiple tabs' do
    login
    visit brand_aliases_url
    new_window = open_new_window
    within_window new_window do
      visit brand_aliases_url
    end

    click_on 'one alias'
    assert_selector("input#brand_alias_#{brand_aliases(:one).id}_alias")
    find("input#brand_alias_#{brand_aliases(:one).id}_alias").send_keys('changed alias', :enter)
    assert_selector("a[href=\"#{polymorphic_path([:edit, brand_aliases(:one)])}\"]", text: 'changed alias')

    within_window new_window do
      assert_selector("a[href=\"#{polymorphic_path([:edit, brand_aliases(:one)])}\"]", text: 'changed alias')
    end
  end

  test 'there should not be a New button on the index page when not nested' do
    login
    visit brand_aliases_url
    assert_no_selector('#brand_aliases_new')
  end

  test 'should create brand alias' do
    login
    visit brand_brand_aliases_url(brand_id: brands(:one))
    click_on 'New'

    find('#brand_alias_new_confirmed--toggle').click
    fill_in 'Alias', with: 'a new alias'
    click_on 'Save'

    assert_selector('a.editable-element', text: 'a new alias')
  end

  test 'should show validation errors on brand alias creation' do
    login
    visit brand_brand_aliases_url(brand_id: brands(:one))
    click_on 'New'

    find('#brand_alias_new_confirmed--toggle').click
    fill_in 'Alias', with: ''
    assert_selector('#brand_alias_new_alias--client_side_invalid_message', text: 'An alias must be entered')
    fill_in 'Alias', with: 'another one'
    click_on 'Save'

    assert_selector(
      '#brand_alias_new_alias--server_side_invalid_message',
      text: 'alias has already been taken'
    )
  end

  test 'should update brand alias' do
    login
    visit brand_alias_url(@brand_alias)
    click_on 'Edit', exact: true

    fill_in 'Alias', with: @brand_alias.alias
    click_on 'Update'

    assert_text "Brand Alias '#{@brand_alias}' was successfully updated"
    click_on 'List'
  end

  test 'should show validation errors on brand alias update' do
    login
    visit brand_alias_url(@brand_alias)
    click_on 'Edit', exact: true

    fill_in 'Alias', with: ''
    assert_selector(
      "#brand_alias_#{@brand_alias.id}_alias--client_side_invalid_message",
      text: 'An alias must be entered'
    )
    fill_in 'Alias', with: 'another one'
    click_on 'Update'
    assert_selector(
      "#brand_alias_#{@brand_alias.id}_alias--server_side_invalid_message",
      text: 'Alias has already been taken'
    )
  end

  test 'should destroy brand alias' do
    login
    visit edit_brand_alias_url(@brand_alias)
    find("#delete_brand_alias_#{@brand_alias.id}").click
    find('#confirm_delete').click

    assert_text "Brand Alias '#{@brand_alias}' was successfully deleted"
  end

  test 'should destroy brand alias inline' do
    login
    visit brand_aliases_url

    assert_selector("#turbo_stream_brand_alias_#{@brand_alias.id}")

    find("#delete_brand_alias_#{@brand_alias.id}").click
    find('#confirm_delete').click

    assert_no_selector("#turbo_stream_brand_alias_#{@brand_alias.id}")
  end

  test 'should view brand alias' do
    login
    visit brand_aliases_url
    find("#view_brand_alias_#{@brand_alias.id}").click
    assert_current_path(brand_alias_path(@brand_alias))
  end

  test 'index page tabs' do
    login
    visit brand_brand_aliases_url(brand_id: brands(:one))
    assert_selector("a#tab_brand_#{brands(:one).id}_details", text: 'Details')
    assert_selector("a#tab_brand_#{brands(:one).id}_brand_aliases", text: 'Aliases')
    assert_selector("a#tab_brand_#{brands(:one).id}_audit", text: 'Audit')

    click_on 'Details'
    assert_current_path(brand_url(brands(:one).id))
    visit brand_brand_aliases_url(brand_id: brands(:one))
    click_on 'Aliases'
    assert_current_path(brand_brand_aliases_url(brand_id: brands(:one)))
    click_on 'Audit'
    assert_current_path(brand_audits_url(brand_id: brands(:one)))
  end

  test 'creating and destroying aliases should update badge count' do
    badge_count = brands(:one).brand_aliases.size
    login
    visit brand_brand_aliases_url(brand_id: brands(:one))
    assert_selector(
      "#tab_brand_#{brands(:one).id}_brand_aliases--badge_count__integer",
      text: badge_count
    )

    click_on 'New'
    find('#brand_alias_new_confirmed--toggle').click
    fill_in 'Alias', with: 'a new alias'
    click_on 'Save'

    assert_selector(
      "#tab_brand_#{brands(:one).id}_brand_aliases--badge_count__integer",
      text: badge_count + 1
    )

    find('button', text: 'Delete', match: :first).click
    find('#confirm_delete').click
    assert_selector(
      "#tab_brand_#{brands(:one).id}_brand_aliases--badge_count__integer",
      text: badge_count
    )
  end
end
