# frozen_string_literal: true

require 'application_system_test_case'

class ItemSellPacksTest < ApplicationSystemTestCase
  setup do
    @item_sell_pack = item_sell_packs(:carton)
  end

  test 'redirects if not logged in' do
    visit item_sell_packs_url
    assert_current_path(root_url)
  end

  test 'visiting the index' do
    login
    visit item_sell_packs_url
    assert_selector 'h1', text: 'Item Sell Packs'
    assert_selector('label', text: 'Name contains')
    assert_selector('input#filter_name[name="q[name_cont]"]')
    assert_selector('label', text: 'Canonical')
    assert_selector('input#q_canonical_true[name="q[canonical_true]"]', visible: false)
    assert_selector('input#q_canonical_not_true[name="q[canonical_not_true]"]', visible: false)
    assert_selector('button#toggle_canonical')
  end

  test 'should automatically page' do
    login
    visit item_sell_packs_url
    assert_selector("#name_cell_item_sell_pack_#{item_sell_packs(:carton).id}", text: 'carton')
    assert_selector("#name_cell_item_sell_pack_#{item_sell_packs(:each).id}", text: 'each')
    assert_selector("#name_cell_item_sell_pack_#{item_sell_packs(:box).id}", text: 'box')
  end

  test 'inline editing and cancelling' do
    login
    visit item_sell_packs_url

    # Click to edit
    click_on 'carton'
    assert_selector("input#item_sell_pack_#{item_sell_packs(:carton).id}_name")

    # Escape to cancel
    find("input#item_sell_pack_#{item_sell_packs(:carton).id}_name").send_keys(:escape)
    assert_selector("a[href=\"#{polymorphic_path([:edit, item_sell_packs(:carton)])}\"]", text: 'carton')

    # Enter to save
    click_on 'carton'
    find("input#item_sell_pack_#{item_sell_packs(:carton).id}_name").send_keys('pack', :enter)
    assert_selector("a[href=\"#{polymorphic_path([:edit, item_sell_packs(:carton)])}\"]", text: 'pack')
  end

  test 'inline editing validation' do
    login
    visit item_sell_packs_url

    # Click to edit
    click_on 'carton'
    assert_selector("input#item_sell_pack_#{item_sell_packs(:carton).id}_name")

    # Set to blank
    find("input#item_sell_pack_#{item_sell_packs(:carton).id}_name").send_keys(:backspace)
    assert_selector(
      "#item_sell_pack_#{item_sell_packs(:carton).id}_name--client_side_invalid_message",
      text: 'A name must be entered'
    )

    # Use a name that already exists
    find("input#item_sell_pack_#{item_sell_packs(:carton).id}_name").send_keys('box', :enter)
    assert_selector(
      "#item_sell_pack_#{item_sell_packs(:carton).id}_name--server_side_invalid_message",
      text: 'Name has already been taken'
    )
  end

  test 'broadcasting updates to multiple tabs' do
    login
    visit item_sell_packs_url
    new_window = open_new_window
    within_window new_window do
      visit item_sell_packs_url
    end

    click_on 'carton'
    assert_selector("input#item_sell_pack_#{item_sell_packs(:carton).id}_name")
    find("input#item_sell_pack_#{item_sell_packs(:carton).id}_name").send_keys('pack', :enter)
    assert_selector("a[href=\"#{polymorphic_path([:edit, item_sell_packs(:carton)])}\"]", text: 'pack')

    within_window new_window do
      assert_selector("a[href=\"#{polymorphic_path([:edit, item_sell_packs(:carton)])}\"]", text: 'pack')
    end
  end

  test 'should create item sell pack' do
    login
    visit item_sell_packs_url
    click_on 'New'

    find('#item_sell_pack_new_canonical--toggle').click
    fill_in 'Name', with: 'a new pack'
    click_on 'Save'

    assert_selector('a.editable-element', text: 'a new pack')
  end

  test 'should show validation errors on item sell pack creation' do
    login
    visit item_sell_packs_url
    click_on 'New'

    find('#item_sell_pack_new_canonical--toggle').click
    fill_in 'Name', with: ''
    assert_selector('#item_sell_pack_new_name--client_side_invalid_message', text: 'A name must be entered')
    fill_in 'Name', with: 'carton'
    click_on 'Save'

    assert_selector('#item_sell_pack_new_name--server_side_invalid_message', text: 'name has already been taken')
  end

  test 'should update Item sell pack' do
    login
    visit item_sell_pack_url(@item_sell_pack)
    click_on 'Edit', match: :first

    fill_in 'Name', with: @item_sell_pack.name
    click_on 'Update'

    assert_text "Item sell pack '#{@item_sell_pack}' was successfully updated"
    click_on 'List'
  end

  test 'should show validation errors on item sell pack update' do
    login
    visit item_sell_pack_url(@item_sell_pack)
    click_on 'Edit', match: :first

    fill_in 'Name', with: ''
    assert_selector(
      "#item_sell_pack_#{@item_sell_pack.id}_name--client_side_invalid_message",
      text: 'A name must be entered'
    )
    fill_in 'Name', with: 'box'
    click_on 'Update'
    assert_selector(
      "#item_sell_pack_#{@item_sell_pack.id}_name--server_side_invalid_message",
      text: 'Name has already been taken'
    )
  end

  test 'should destroy Item sell pack' do
    login
    visit edit_item_sell_pack_url(@item_sell_pack)
    find("#delete_item_sell_pack_#{@item_sell_pack.id}").click
    find('#confirm_delete').click

    assert_text "Item sell pack '#{@item_sell_pack}' was successfully deleted"
  end

  test 'should destroy Item sell pack inline' do
    login
    visit item_sell_packs_url

    assert_selector("#turbo_stream_item_sell_pack_#{@item_sell_pack.id}")

    find("#delete_item_sell_pack_#{@item_sell_pack.id}").click
    find('#confirm_delete').click

    assert_no_selector("#turbo_stream_item_sell_pack_#{@item_sell_pack.id}")
  end

  test 'should view Item sell pack' do
    login
    visit item_sell_packs_url
    find("#view_item_sell_pack_#{@item_sell_pack.id}").click
    assert_current_path(item_sell_pack_path(@item_sell_pack))
  end

  test 'show page tabs' do
    login
    visit item_sell_pack_url(@item_sell_pack)
    assert_selector("a#tab_item_sell_pack_#{@item_sell_pack.id}_details", text: 'Details')
    assert_selector("a#tab_item_sell_pack_#{@item_sell_pack.id}_item_sell_pack_aliases", text: 'Aliases')
    assert_selector("a#tab_item_sell_pack_#{@item_sell_pack.id}_audit", text: 'Audit')

    click_on 'Details'
    assert_current_path(item_sell_pack_url(@item_sell_pack))
    click_on 'Aliases'
    assert_current_path(item_sell_pack_item_sell_pack_aliases_url(item_sell_pack_id: @item_sell_pack))
  end

  test 'edit page tabs' do
    login
    visit edit_item_sell_pack_url(@item_sell_pack)
    assert_selector("a#tab_item_sell_pack_#{@item_sell_pack.id}_details", text: 'Details')
    assert_selector("a#tab_item_sell_pack_#{@item_sell_pack.id}_item_sell_pack_aliases", text: 'Aliases')
    assert_selector("a#tab_item_sell_pack_#{@item_sell_pack.id}_audit", text: 'Audit')

    click_on 'Details'
    assert_current_path(edit_item_sell_pack_url(@item_sell_pack))
    click_on 'Aliases'
    assert_current_path(item_sell_pack_item_sell_pack_aliases_url(item_sell_pack_id: @item_sell_pack))
  end

  test 'updating record should update audits badge count' do
    badge_count = item_sell_packs(:carton).associated_audits.size
    login
    visit edit_item_sell_pack_url(@item_sell_pack)
    assert_selector(
      "#tab_item_sell_pack_#{item_sell_packs(:carton).id}_audit--badge_count__integer",
      text: badge_count
    )

    fill_in 'Name', with: "updated #{@item_sell_pack.name}"
    click_on 'Update'

    assert_selector(
      "#tab_item_sell_pack_#{item_sell_packs(:carton).id}_audit--badge_count__integer",
      text: badge_count + 1
    )
  end
end
