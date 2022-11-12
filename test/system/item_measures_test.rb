# frozen_string_literal: true

require 'application_system_test_case'

class ItemMeasuresTest < ApplicationSystemTestCase
  setup do
    @item_measure = item_measures(:one)
  end

  test 'redirects if not logged in' do
    visit item_measures_url
    assert_current_path(root_url)
  end

  test 'visiting the index' do
    login
    visit item_measures_url
    assert_selector('h1', text: 'Item Measures')
    assert_selector('label', text: 'Name contains')
    assert_selector('input#filter_name[name="q[name_cont]"]')
    assert_selector('label', text: 'Canonical')
    assert_selector('input#q_canonical_true[name="q[canonical_true]"]', visible: false)
    assert_selector('input#q_canonical_not_true[name="q[canonical_not_true]"]', visible: false)
    assert_selector('button#toggle_canonical')
  end

  test 'should automatically page' do
    login
    visit item_measures_url
    assert_selector("#name_cell_item_measure_#{item_measures(:one).id}", text: 'ml')
    assert_selector("#name_cell_item_measure_#{item_measures(:two).id}", text: 'l')
    assert_selector("#name_cell_item_measure_#{item_measures(:three).id}", text: 'kg')
  end

  test 'inline editing and cancelling' do
    login
    visit item_measures_url

    # Click to edit
    click_on 'ml'
    assert_selector("input#item_measure_#{@item_measure.id}_name")

    # Escape to cancel
    find("input#item_measure_#{@item_measure.id}_name").send_keys(:escape)
    assert_selector("a[href=\"#{polymorphic_path([:edit, @item_measure])}\"]", text: 'ml')

    # Enter to save
    click_on 'ml'
    find("input#item_measure_#{@item_measure.id}_name").send_keys('millilitres', :enter)
    assert_selector("a[href=\"#{polymorphic_path([:edit, @item_measure])}\"]", text: 'millilitres')

    # Canonical
    assert_selector("#canonical_item_measure_#{@item_measure.id}[value=\"true\"]", visible: false)
    find("#canonical_toggle_item_measure_#{@item_measure.id}--button").click
    assert_selector("#canonical_item_measure_#{@item_measure.id}[value=\"false\"]", visible: false)
  end

  test 'inline editing validation' do
    login
    visit item_measures_url

    # Click to edit
    click_on 'ml'
    assert_selector("input#item_measure_#{@item_measure.id}_name")

    # Set to blank
    find("input#item_measure_#{@item_measure.id}_name").send_keys(:backspace)
    assert_selector(
      "#item_measure_#{@item_measure.id}_name--client_side_invalid_message",
      text: 'A name must be entered'
    )

    # Use a name that already exists
    find("input#item_measure_#{@item_measure.id}_name").send_keys('kg', :enter)
    assert_selector(
      "#item_measure_#{@item_measure.id}_name--server_side_invalid_message",
      text: 'Name has already been taken'
    )
  end

  test 'broadcasting updates to multiple tabs' do
    login
    visit item_measures_url
    new_window = open_new_window
    within_window new_window do
      visit item_measures_url
    end

    click_on 'ml'
    assert_selector("input#item_measure_#{@item_measure.id}_name")
    find("input#item_measure_#{@item_measure.id}_name").send_keys('millilitre', :enter)
    assert_selector("a[href=\"#{polymorphic_path([:edit, @item_measure])}\"]", text: 'millilitre')

    within_window new_window do
      assert_selector("a[href=\"#{polymorphic_path([:edit, @item_measure])}\"]", text: 'millilitre')
    end
  end

  test 'should create item measure' do
    login
    visit item_measures_url
    click_on 'New'

    find('#item_measure_new_canonical--toggle').click
    fill_in 'Name', with: 'a new measure'
    click_on 'Save'

    assert_selector('a.editable-element', text: 'a new measure')
  end

  test 'should show validation errors on item measure creation' do
    login
    visit item_measures_url
    click_on 'New'

    find('#item_measure_new_canonical--toggle').click
    fill_in 'Name', with: ''
    assert_selector('#item_measure_new_name--client_side_invalid_message', text: 'A name must be entered')
    fill_in 'Name', with: 'ml'
    click_on 'Save'

    assert_selector('#item_measure_new_name--server_side_invalid_message', text: 'name has already been taken')
  end

  test 'should update Item measure' do
    login
    visit item_measure_url(@item_measure)
    click_on 'Edit', exact: true

    fill_in 'Name', with: @item_measure.name
    click_on 'Update'

    assert_text "Item Measure '#{@item_measure}' was successfully updated"
    click_on 'List'
  end

  test 'should show validation errors on item measure update' do
    login
    visit item_measure_url(@item_measure)
    click_on 'Edit', exact: true

    fill_in 'Name', with: ''
    assert_selector(
      "#item_measure_#{@item_measure.id}_name--client_side_invalid_message",
      text: 'A name must be entered'
    )
    fill_in 'Name', with: 'kg'
    click_on 'Update'
    assert_selector(
      "#item_measure_#{@item_measure.id}_name--server_side_invalid_message",
      text: 'Name has already been taken'
    )
  end

  test 'should destroy Item measure' do
    login
    visit edit_item_measure_url(@item_measure)
    find("#delete_item_measure_#{@item_measure.id}").click
    find('#confirm_delete').click

    assert_text "Item Measure '#{@item_measure}' was successfully deleted"
  end

  test 'should destroy Item measure inline' do
    login
    visit item_measures_url

    assert_selector("#turbo_stream_item_measure_#{@item_measure.id}")

    find("#delete_item_measure_#{@item_measure.id}").click
    find('#confirm_delete').click

    assert_no_selector("#turbo_stream_item_measure_#{@item_measure.id}")
  end

  test 'should view Item measure' do
    login
    visit item_measures_url
    find("#view_item_measure_#{@item_measure.id}").click
    assert_current_path(item_measure_path(@item_measure))
  end

  test 'show page tabs' do
    login
    visit item_measure_url(@item_measure)
    assert_selector("a#tab_item_measure_#{@item_measure.id}_details", text: 'Details')
    assert_selector("a#tab_item_measure_#{@item_measure.id}_item_measure_aliases", text: 'Aliases')
    assert_selector("a#tab_item_measure_#{@item_measure.id}_audit", text: 'Audit')

    click_on 'Details'
    assert_current_path(item_measure_url(@item_measure))
    click_on 'Aliases'
    assert_current_path(item_measure_item_measure_aliases_url(item_measure_id: @item_measure))
  end

  test 'edit page tabs' do
    login
    visit edit_item_measure_url(@item_measure)
    assert_selector("a#tab_item_measure_#{@item_measure.id}_details", text: 'Details')
    assert_selector("a#tab_item_measure_#{@item_measure.id}_item_measure_aliases", text: 'Aliases')
    assert_selector("a#tab_item_measure_#{@item_measure.id}_audit", text: 'Audit')

    click_on 'Details'
    assert_current_path(edit_item_measure_url(@item_measure))
    click_on 'Aliases'
    assert_current_path(item_measure_item_measure_aliases_url(item_measure_id: @item_measure))
  end

  test 'updating record should update audits badge count' do
    badge_count = item_measures(:one).associated_audits.size
    login
    visit edit_item_measure_url(@item_measure)
    assert_selector(
      "#tab_item_measure_#{item_measures(:one).id}_audit--badge_count__integer",
      text: badge_count
    )

    fill_in 'Name', with: "updated #{@item_measure.name}"
    click_on 'Update'

    assert_selector(
      "#tab_item_measure_#{item_measures(:one).id}_audit--badge_count__integer",
      text: badge_count + 1
    )
  end
end
