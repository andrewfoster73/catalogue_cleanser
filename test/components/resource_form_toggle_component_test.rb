# frozen_string_literal: true

require 'test_helper'

class ResourceForm::ToggleComponentTest < ViewComponent::TestCase
  def setup
    @resource = build(:item_sell_pack, name: 'carton', canonical: true, created_at: Time.zone.now)
  end

  test 'editable mode' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_toggle(attribute: :canonical, label: 'Canonical', resource: @resource, readonly: false)
    end

    assert_selector('#item_sell_pack_canonical--label')
    assert_selector('label[for="item_sell_pack_canonical"]', text: 'Canonical')
    assert_selector('input#item_sell_pack_canonical[value="true"]', visible: false)
    assert_selector('input#item_sell_pack_canonical[name="item_sell_pack[canonical]"]', visible: false)
    assert_selector('button#item_sell_pack_canonical--toggle[data-action="click->resource-form--component#toggle"]')
    assert_selector(
      'button#item_sell_pack_canonical--toggle[data-resource-form--component-toggle-id-param="toggle_canonical"]'
    )
    assert_selector(
      'button#item_sell_pack_canonical--toggle[data-resource-form--component-field-id-param="item_sell_pack_canonical"]'
    )
  end

  test 'readonly mode' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_toggle(attribute: :canonical, label: 'Canonical', resource: @resource, readonly: true)
    end

    assert_selector('#item_sell_pack_canonical--label')
    assert_selector('label[for="item_sell_pack_canonical"]', text: 'Canonical')
    assert_selector('input#item_sell_pack_canonical[value="true"]', visible: false)
    assert_selector('input#item_sell_pack_canonical[name="item_sell_pack[canonical]"]', visible: false)
    assert_selector('button#item_sell_pack_canonical--toggle[data-action=""]')
  end

  test 'with help text' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_toggle(
        attribute: :canonical, label: 'Canonical', resource: @resource, readonly: false, help: 'This is a help message'
      )
    end

    assert_selector('#item_sell_pack_canonical--help', text: 'This is a help message')
  end
end
