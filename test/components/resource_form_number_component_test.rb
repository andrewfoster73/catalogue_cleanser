# frozen_string_literal: true

require 'test_helper'

class ResourceForm::NumberComponentTest < ViewComponent::TestCase
  def setup
    @resource = build(:product, id: 1, item_size: 1.0)
  end

  test 'editable mode' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_number(
        attribute: :item_size,
        label: 'Item Size',
        resource: @resource,
        options: {
          readonly: false,
          required: true,
          min: 0.0,
          step: 0.0001,
          invalid_message: I18n.t('products.resource.invalid_message.item_size')
        }
      )
    end

    assert_selector('#product_1_item_size--label')
    assert_selector('label[for="product_1_item_size"]', text: 'Item Size')
    assert_selector('input#product_1_item_size[value="1.0"]')
    assert_selector('input#product_1_item_size[name="product[item_size]"]')
  end

  test 'readonly mode' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_number(
        attribute: :item_size,
        label: 'Item Size',
        resource: @resource,
        options: { readonly: true }
      )
    end

    assert_selector('#product_1_item_size--label')
    assert_selector('label[for="product_1_item_size"]', text: 'Item Size')
    assert_selector('p#product_1_item_size', text: '1.0')
  end

  test 'with help text' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_text(
        attribute: :item_size,
        label: 'Item Size',
        resource: @resource,
        options: { readonly: false, help: 'This is a help message' }
      )
    end

    assert_selector('#product_1_item_size--help', text: 'This is a help message')
  end
end
