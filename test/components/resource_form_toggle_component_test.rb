# frozen_string_literal: true

require 'test_helper'

class ResourceForm::ToggleComponentTest < ViewComponent::TestCase
  def setup
    @resource = build(:item_sell_pack, id: 1, name: 'carton', canonical: true, created_at: Time.zone.now)
  end

  # rubocop:disable Layout/LineLength
  test 'editable mode' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_toggle(
        attribute: :canonical,
        label: 'Canonical',
        resource: @resource,
        options: { readonly: false }
      )
    end

    assert_selector('#item_sell_pack_1_canonical--label')
    assert_selector('label[for="item_sell_pack_1_canonical"]', text: 'Canonical')
    assert_selector('input#item_sell_pack_1_canonical[value="true"]', visible: false)
    assert_selector('input#item_sell_pack_1_canonical[name="item_sell_pack[canonical]"]', visible: false)
    assert_selector('button#item_sell_pack_1_canonical--toggle[data-action="click->resource-form--component#toggle"]')
    assert_selector(
      'button#item_sell_pack_1_canonical--toggle[data-resource-form--component-toggle-id-param="item_sell_pack_1_toggle_canonical"]'
    )
    assert_selector(
      'button#item_sell_pack_1_canonical--toggle' \
      '[data-resource-form--component-field-id-param="item_sell_pack_1_canonical"]'
    )
  end
  # rubocop:enable Layout/LineLength

  test 'readonly mode' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_toggle(
        attribute: :canonical,
        label: 'Canonical',
        resource: @resource,
        options: { readonly: true }
      )
    end

    assert_selector('#item_sell_pack_1_canonical--label')
    assert_selector('label[for="item_sell_pack_1_canonical"]', text: 'Canonical')
    assert_selector('input#item_sell_pack_1_canonical[value="true"]', visible: false)
    assert_selector('input#item_sell_pack_1_canonical[name="item_sell_pack[canonical]"]', visible: false)
    assert_selector('button#item_sell_pack_1_canonical--toggle[data-action=""]')
  end

  test 'with help text' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_toggle(
        attribute: :canonical,
        label: 'Canonical',
        resource: @resource,
        options: { readonly: false, help: 'This is a help message' }
      )
    end

    assert_selector('#item_sell_pack_1_canonical--help', text: 'This is a help message')
  end
end
