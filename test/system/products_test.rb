# frozen_string_literal: true

require 'application_system_test_case'

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:lager)
  end

  test 'redirects if not logged in' do
    visit products_url
    assert_current_path(root_url)
  end

  test 'visiting the index' do
    login
    visit products_url
    assert_selector 'h1', text: 'Products'
    assert_selector('label', text: 'Description contains')
    assert_selector('input#filter_item_description[name="q[item_description_cont]"]')
  end

  test 'should automatically page' do
    login
    visit products_url
    assert_selector("#item_description_cell_product_#{products(:lager).id}", text: 'Lager')
    assert_selector("#item_description_cell_product_#{products(:apple).id}", text: 'Apple')
    assert_selector("#item_description_cell_product_#{products(:mince).id}", text: 'Beef Mince')
  end

  test 'inline editing and cancelling' do
    login
    visit products_url

    # Click to edit
    click_on 'Lager'
    assert_selector("input#product_#{@product.id}_item_description")

    # Escape to cancel
    find("input#product_#{@product.id}_item_description").send_keys(:escape)
    assert_selector("a[href=\"#{polymorphic_path([:edit, @product])}\"]", text: 'Lager')

    # Enter to save
    click_on 'Lager'
    find("input#product_#{@product.id}_item_description").send_keys('Beer', :enter)
    assert_selector("a[href=\"#{polymorphic_path([:edit, @product])}\"]", text: 'Beer')

    # Click to edit
    click_on 'carton'
    assert_selector("input#product_#{@product.id}_item_sell_pack_name--input")

    # Escape to cancel
    find("input#product_#{@product.id}_item_sell_pack_name--input").send_keys(:escape)
    assert_selector("a[href=\"#{polymorphic_path([:edit, @product])}\"]", text: 'carton')

    # Select to save
    click_on 'carton'
    find("#product_#{@product.id}_item_sell_pack_name--button").click
    find("#product_#{@product.id}_item_sell_pack_name--box-value").click
    assert_selector("a[href=\"#{polymorphic_path([:edit, @product])}\"]", text: 'box')
  end

  test 'inline editing validation' do
    login
    visit products_url

    # Click to edit
    click_on 'Lager'
    assert_selector("input#product_#{@product.id}_item_description")

    # Set to blank
    find("input#product_#{@product.id}_item_description").send_keys(:backspace)
    assert_selector(
      "#product_#{@product.id}_item_description--client_side_invalid_message",
      text: 'A description must be entered'
    )
  end

  test 'broadcasting updates to multiple tabs' do
    login
    visit products_url
    new_window = open_new_window
    within_window new_window do
      visit products_url
      assert_selector("a[href=\"#{polymorphic_path([:edit, products(:apple)])}\"]", text: 'Apple')
    end

    click_on 'Apple'
    assert_selector("input#product_#{products(:apple).id}_item_description")
    find("input#product_#{products(:apple).id}_item_description").send_keys('Pear', :enter)
    assert_selector("a[href=\"#{polymorphic_path([:edit, products(:apple)])}\"]", text: 'Pear')

    within_window new_window do
      assert_selector("a[href=\"#{polymorphic_path([:edit, products(:apple)])}\"]", text: 'Pear')
    end
  end

  test 'should update product' do
    login
    visit product_url(@product)
    click_on 'Edit', exact: true

    fill_in 'Description', with: @product.item_description
    click_on 'Update'

    assert_text "Product '#{@product}' was successfully updated"
    click_on 'List'
  end

  test 'should show validation errors on product update' do
    login
    visit product_url(@product)
    click_on 'Edit', exact: true

    fill_in 'Description', with: ''
    assert_selector(
      "#product_#{@product.id}_item_description--client_side_invalid_message",
      text: 'A description must be entered'
    )
  end

  test 'should destroy product' do
    login
    visit edit_product_url(@product)
    find("#delete_product_#{@product.id}").click
    find('#confirm_delete').click

    assert_text "Product '#{@product}' was successfully deleted"
  end

  test 'should destroy product inline' do
    login
    visit products_url

    assert_selector("#turbo_stream_product_#{@product.id}")

    find("#delete_product_#{@product.id}").click
    find('#confirm_delete').click

    assert_no_selector("#turbo_stream_product_#{@product.id}")
  end

  test 'should view product' do
    login
    visit products_url
    find("#view_product_#{@product.id}").click
    assert_current_path(product_path(@product))
  end

  test 'show page tabs' do
    login
    visit product_url(@product)
    assert_selector("a#tab_product_#{@product.id}_details", text: 'Details')
    assert_selector("a#tab_product_#{@product.id}_product_translations", text: 'Translations')
    assert_selector("a#tab_product_#{@product.id}_audit", text: 'Audit')

    click_on 'Details'
    assert_current_path(product_url(@product))
    click_on 'Translations'
    assert_current_path(product_product_translations_url(product_id: @product))
  end

  test 'edit page tabs' do
    login
    visit edit_product_url(@product)
    assert_selector("a#tab_product_#{@product.id}_details", text: 'Details')
    assert_selector("a#tab_product_#{@product.id}_product_translations", text: 'Translations')
    assert_selector("a#tab_product_#{@product.id}_audit", text: 'Audit')

    click_on 'Details'
    assert_current_path(edit_product_url(@product))
    click_on 'Translations'
    assert_current_path(product_product_translations_url(product_id: @product))
  end

  test 'updating record should update audits badge count' do
    badge_count = @product.own_and_associated_audits.size
    login
    visit edit_product_url(@product)
    assert_selector(
      "#tab_product_#{@product.id}_audit--badge_count__integer",
      text: badge_count
    )

    fill_in 'Description', with: "updated #{@product.item_description}"
    click_on 'Update'

    assert_selector(
      "#tab_product_#{@product.id}_audit--badge_count__integer",
      text: badge_count + 3
    )
  end
end
