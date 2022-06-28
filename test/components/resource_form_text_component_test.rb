# frozen_string_literal: true

require 'test_helper'

class ResourceForm::TextComponentTest < ViewComponent::TestCase
  def setup
    @resource = build(:item_sell_pack, name: 'carton', canonical: true, created_at: Time.zone.now)
  end

  test 'editable mode' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_text(attribute: :name, label: 'Name', resource: @resource, readonly: false)
    end

    assert_selector('#item_sell_pack_name--label')
    assert_selector('label[for="item_sell_pack_name"]', text: 'Name')
    assert_selector('input#item_sell_pack_name[value="carton"]')
    assert_selector('input#item_sell_pack_name[name="item_sell_pack[name]"]')
  end

  test 'readonly mode' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_text(attribute: :name, label: 'Name', resource: @resource, readonly: true)
    end

    assert_selector('#item_sell_pack_name--label')
    assert_selector('label[for="item_sell_pack_name"]', text: 'Name')
    assert_selector('p#item_sell_pack_name', text: 'carton')
  end

  test 'with help text' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_text(
        attribute: :name, label: 'Name', resource: @resource, readonly: false, help: 'This is a help message'
      )
    end

    assert_selector('#item_sell_pack_name--help', text: 'This is a help message')
  end
end
