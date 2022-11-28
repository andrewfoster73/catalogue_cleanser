# frozen_string_literal: true

require 'test_helper'

class ResourceForm::TreeSelectComponentTest < ViewComponent::TestCase
  def setup
    @resource = products(:lager)
  end

  test 'with a selected value' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_tree_select(
        root_class: External::Category,
        attribute: :category_id,
        label: 'Categories',
        resource: @resource,
        hidden: false,
        options: { readonly: false }
      )
    end

    assert_selector("#product_#{@resource.id}_category_id--label", text: 'Categories')
    assert_selector("#product_#{@resource.id}_category_id--input[value=\"Brewskis\"]")
    assert_selector("#product_#{@resource.id}_category_id--hidden-input[value=\"#{@resource.category_id}\"]", visible: false)
    assert_selector("#product_#{@resource.id}_category_id--button")
  end

  test 'without a selected value' do
    @resource.category_id = nil
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_tree_select(
        root_class: External::Category,
        attribute: :category_id,
        label: 'Categories',
        resource: @resource,
        hidden: false,
        options: { readonly: false }
      )
    end

    assert_no_selector("span#product_#{@resource.id}_category_id--#{@resource.category_id}-checkmark")
  end

  test 'readonly mode' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_tree_select(
        root_class: External::Category,
        attribute: :category_id,
        label: 'Categories',
        resource: @resource,
        hidden: false,
        options: { readonly: true }
      )
    end

    assert_no_selector("#product_#{@resource.id}_category_id--button")
  end

  test 'with help text' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_tree_select(
        root_class: External::Category,
        attribute: :category_id,
        label: 'Categories',
        resource: @resource,
        options: { readonly: false, help: 'This is some help' }
      )
    end

    assert_selector("#product_#{@resource.id}_category_id--help", text: 'This is some help')
  end
end
