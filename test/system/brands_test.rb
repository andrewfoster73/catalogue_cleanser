# frozen_string_literal: true

require 'application_system_test_case'

class BrandsTest < ApplicationSystemTestCase
  setup do
    @brand = brands(:one)
  end

  test 'redirects if not logged in' do
    visit brands_url
    assert_current_path(root_url)
  end

  test 'visiting the index' do
    login
    visit brands_url
    assert_selector('h1', text: 'Brands')
    assert_selector('label', text: 'Name contains')
    assert_selector('input#filter_name[name="q[name_cont]"]')
    assert_selector('label', text: 'Canonical')
    assert_selector('input#q_canonical_true[name="q[canonical_true]"]', visible: false)
    assert_selector('input#q_canonical_not_true[name="q[canonical_not_true]"]', visible: false)
    assert_selector('button#toggle_canonical')
  end

  test 'should automatically page' do
    login
    visit brands_url
    assert_selector("#name_cell_brand_#{brands(:one).id}", text: 'Heinz')
    assert_selector("#name_cell_brand_#{brands(:two).id}", text: 'S.P.C.')
    assert_selector("#name_cell_brand_#{brands(:three).id}", text: 'Apple')
  end

  test 'inline editing and cancelling' do
    login
    visit brands_url

    # Click to edit
    click_on 'Heinz'
    assert_selector("input#brand_#{@brand.id}_name")

    # Escape to cancel
    find("input#brand_#{@brand.id}_name").send_keys(:escape)
    assert_selector("a[href=\"#{polymorphic_path([:edit, @brand])}\"]", text: 'Heinz')

    # Enter to save
    click_on 'Heinz'
    find("input#brand_#{@brand.id}_name").send_keys('Branston', :enter)
    assert_selector("a[href=\"#{polymorphic_path([:edit, @brand])}\"]", text: 'Branston')

    # Canonical
    assert_selector("#canonical_brand_#{@brand.id}[value=\"true\"]", visible: false)
    find("#canonical_toggle_brand_#{@brand.id}--button").click
    assert_selector("#canonical_brand_#{@brand.id}[value=\"false\"]", visible: false)
  end

  test 'inline editing validation' do
    login
    visit brands_url

    # Click to edit
    click_on 'Heinz'
    assert_selector("input#brand_#{@brand.id}_name")

    # Set to blank
    find("input#brand_#{@brand.id}_name").send_keys(:backspace)
    assert_selector(
      "#brand_#{@brand.id}_name--client_side_invalid_message",
      text: 'A name must be entered'
    )

    # Use a name that already exists
    find("input#brand_#{@brand.id}_name").send_keys('S.P.C.', :enter)
    assert_selector(
      "#brand_#{@brand.id}_name--server_side_invalid_message",
      text: 'Name has already been taken'
    )
  end

  test 'broadcasting updates to multiple tabs' do
    login
    visit brands_url
    new_window = open_new_window
    within_window new_window do
      visit brands_url
    end

    click_on 'Heinz'
    assert_selector("input#brand_#{@brand.id}_name")
    find("input#brand_#{@brand.id}_name").send_keys('Branston', :enter)
    assert_selector("a[href=\"#{polymorphic_path([:edit, @brand])}\"]", text: 'Branston')

    within_window new_window do
      assert_selector("a[href=\"#{polymorphic_path([:edit, @brand])}\"]", text: 'Branston')
    end
  end

  test 'should create brand' do
    login
    visit brands_url
    click_on 'New'

    find('#brand_new_canonical--toggle').click
    fill_in 'Name', with: 'a new brand'
    click_on 'Save'

    assert_selector('a.editable-element', text: 'a new brand')
  end

  test 'should show validation errors on brand creation' do
    login
    visit brands_url
    click_on 'New'

    find('#brand_new_canonical--toggle').click
    fill_in 'Name', with: ''
    assert_selector('#brand_new_name--client_side_invalid_message', text: 'A name must be entered')
    fill_in 'Name', with: 'Heinz'
    click_on 'Save'

    assert_selector('#brand_new_name--server_side_invalid_message', text: 'name has already been taken')
  end

  test 'should update brand' do
    login
    visit brand_url(@brand)
    click_on 'Edit', exact: true

    fill_in 'Name', with: @brand.name
    click_on 'Update'

    assert_text "Brand '#{@brand}' was successfully updated"
    click_on 'List'
  end

  test 'should show validation errors on brand update' do
    login
    visit brand_url(@brand)
    click_on 'Edit', exact: true

    fill_in 'Name', with: ''
    assert_selector(
      "#brand_#{@brand.id}_name--client_side_invalid_message",
      text: 'A name must be entered'
    )
    fill_in 'Name', with: 'S.P.C.'
    click_on 'Update'
    assert_selector(
      "#brand_#{@brand.id}_name--server_side_invalid_message",
      text: 'Name has already been taken'
    )
  end

  test 'should destroy brand' do
    login
    visit edit_brand_url(@brand)
    find("#delete_brand_#{@brand.id}").click
    find('#confirm_delete').click

    assert_text "Brand '#{@brand}' was successfully deleted"
  end

  test 'should destroy brand inline' do
    login
    visit brands_url

    assert_selector("#turbo_stream_brand_#{@brand.id}")

    find("#delete_brand_#{@brand.id}").click
    find('#confirm_delete').click

    assert_no_selector("#turbo_stream_brand_#{@brand.id}")
  end

  test 'should view brand' do
    login
    visit brands_url
    find("#view_brand_#{@brand.id}").click
    assert_current_path(brand_path(@brand))
  end

  test 'should show trademark button' do
    login
    visit brand_url(@brand)
    assert_selector(
      "#check_trademark_brand_#{@brand.id}[data-resource-url-param=\"#{@brand.trademark_check_url}\"]",
      text: 'Trademark'
    )
    visit edit_brand_url(@brand)
    assert_selector(
      "#check_trademark_brand_#{@brand.id}[data-resource-url-param=\"#{@brand.trademark_check_url}\"]",
      text: 'Trademark'
    )
  end

  test 'show page tabs' do
    login
    visit brand_url(@brand)
    assert_selector("a#tab_brand_#{@brand.id}_details", text: 'Details')
    assert_selector("a#tab_brand_#{@brand.id}_brand_aliases", text: 'Aliases')
    assert_selector("a#tab_brand_#{@brand.id}_audit", text: 'Audit')

    click_on 'Details'
    assert_current_path(brand_url(@brand))
    click_on 'Aliases'
    assert_current_path(brand_brand_aliases_url(brand_id: @brand))
  end

  test 'edit page tabs' do
    login
    visit edit_brand_url(@brand)
    assert_selector("a#tab_brand_#{@brand.id}_details", text: 'Details')
    assert_selector("a#tab_brand_#{@brand.id}_brand_aliases", text: 'Aliases')
    assert_selector("a#tab_brand_#{@brand.id}_audit", text: 'Audit')

    click_on 'Details'
    assert_current_path(edit_brand_url(@brand))
    click_on 'Aliases'
    assert_current_path(brand_brand_aliases_url(brand_id: @brand))
  end

  test 'updating record should update audits badge count' do
    badge_count = brands(:one).associated_audits.size
    login
    visit edit_brand_url(@brand)
    assert_selector(
      "#tab_brand_#{brands(:one).id}_audit--badge_count__integer",
      text: badge_count
    )

    fill_in 'Name', with: "updated #{@brand.name}"
    click_on 'Update'

    assert_selector(
      "#tab_brand_#{brands(:one).id}_audit--badge_count__integer",
      text: badge_count + 1
    )
  end
end
