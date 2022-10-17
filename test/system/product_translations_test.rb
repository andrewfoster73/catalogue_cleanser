# frozen_string_literal: true

require 'application_system_test_case'

class ProductTranslationsTest < ApplicationSystemTestCase
  setup do
    @product = products(:lager)
    @product_translation = product_translations(:lager)
  end

  test 'redirects if not logged in' do
    visit product_product_translations_url(product_id: @product)
    assert_current_path(root_url)
  end

  test 'visiting the index' do
    login
    visit product_product_translations_url(product_id: @product)
    assert_selector 'h1', text: 'Translations'
    assert_selector('label', text: 'Description contains')
    assert_selector('input#filter_item_description[name="q[item_description_cont]"]')
  end

  test 'index page tabs' do
    login
    visit product_product_translations_url(product_id: @product)
    assert_selector("a#tab_product_#{@product.id}_details", text: 'Details')
    assert_selector("a#tab_product_#{@product.id}_product_translations", text: 'Translations')
    assert_selector("a#tab_product_#{@product.id}_product_issues", text: 'Issues')
    assert_selector("a#tab_product_#{@product.id}_audit", text: 'Audit')

    click_on 'Details'
    assert_current_path(product_url(@product))
    click_on 'Translations'
    assert_current_path(product_product_translations_url(product_id: @product))
    click_on 'Issues'
    assert_current_path(product_product_issues_url(product_id: @product))
    click_on 'Audit'
    assert_current_path(product_audits_url(product_id: @product))
  end

  test 'inline editing and cancelling' do
    login
    visit product_product_translations_url(product_id: @product)

    # Click to edit
    find("#item_description_editable_element_product_translation_#{@product_translation.id}").click
    assert_selector("input#product_translation_#{@product_translation.id}_item_description")

    # Escape to cancel
    find("input#product_translation_#{@product_translation.id}_item_description").send_keys(:escape)
    assert_selector("a[href=\"#{polymorphic_path([:edit, @product_translation])}\"]", text: 'Lager')

    # Enter to save
    find("#item_description_editable_element_product_translation_#{@product_translation.id}").click
    find("input#product_translation_#{@product_translation.id}_item_description").send_keys('Beer', :enter)
    assert_selector("a[href=\"#{polymorphic_path([:edit, @product_translation])}\"]", text: 'Beer')

    # Click to edit
    click_on 'carton'
    assert_selector("input#product_translation_#{@product_translation.id}_item_sell_pack_name--input")

    # Escape to cancel
    find("input#product_translation_#{@product_translation.id}_item_sell_pack_name--input").send_keys(:escape)
    assert_selector("a[href=\"#{polymorphic_path([:edit, @product_translation])}\"]", text: 'carton')

    # Select to save
    click_on 'carton'
    find("#product_translation_#{@product_translation.id}_item_sell_pack_name--button").click
    find("#product_translation_#{@product_translation.id}_item_sell_pack_name--box-value").click
    assert_selector("a[href=\"#{polymorphic_path([:edit, @product_translation])}\"]", text: 'box')
  end

  test 'inline editing validation' do
    login
    visit product_product_translations_url(product_id: @product)

    # Click to edit
    find("#item_description_editable_element_product_translation_#{@product_translation.id}").click
    assert_selector("input#product_translation_#{@product_translation.id}_item_description")

    # Set to blank
    find("input#product_translation_#{@product_translation.id}_item_description").send_keys(:backspace)
    assert_selector(
      "#product_translation_#{@product_translation.id}_item_description--client_side_invalid_message",
      text: 'A description must be entered'
    )
  end

  test 'broadcasting updates to multiple tabs' do
    login
    visit product_product_translations_url(product_id: @product)
    new_window = open_new_window
    within_window new_window do
      visit product_product_translations_url(product_id: @product)
    end

    find("#item_description_editable_element_product_translation_#{@product_translation.id}").click
    assert_selector("input#product_translation_#{@product_translation.id}_item_description")
    find("input#product_translation_#{@product_translation.id}_item_description").send_keys('Beer', :enter)
    assert_selector("a[href=\"#{polymorphic_path([:edit, @product_translation])}\"]", text: 'Beer')

    within_window new_window do
      assert_selector("a[href=\"#{polymorphic_path([:edit, @product_translation])}\"]", text: 'Beer')
    end
  end

  test 'there should not be a New button on the index page when not nested' do
    login
    visit product_translations_url
    assert_no_selector('#product_translations_new')
  end

  test 'should update product translation' do
    login
    visit product_translation_url(@product_translation)
    click_on 'Edit', exact: true

    fill_in 'Description', with: @product_translation.item_description
    click_on 'Update'

    assert_text "Translation '#{@product_translation}' was successfully updated"
    click_on 'List'
  end

  test 'should show validation errors on product translation update' do
    login
    visit product_translation_url(@product_translation)
    click_on 'Edit', exact: true

    fill_in 'Description', with: ''
    assert_selector(
      "#product_translation_#{@product_translation.id}_item_description--client_side_invalid_message",
      text: 'A description must be entered'
    )
  end

  test 'should destroy product translation' do
    login
    visit edit_product_translation_url(@product_translation)
    find("#delete_product_translation_#{@product_translation.id}").click
    find('#confirm_delete').click

    assert_text "Translation '#{@product_translation}' was successfully deleted"
  end

  test 'should destroy product translation inline' do
    login
    visit product_translations_url

    assert_selector("#turbo_stream_product_translation_#{@product_translation.id}")

    find("#delete_product_translation_#{@product_translation.id}").click
    find('#confirm_delete').click

    assert_no_selector("#turbo_stream_product_translation_#{@product_translation.id}")
  end

  test 'should view product translation' do
    login
    visit product_product_translations_url(product_id: @product)
    find("#view_product_translation_#{@product.id}").click
    assert_current_path(product_translation_path(@product))
  end
end
