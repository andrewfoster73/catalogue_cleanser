# frozen_string_literal: true

require 'test_helper'

class ResourceForm::LocaleDropdownComponentTest < ViewComponent::TestCase
  def setup
    @resource = users(:saul)
  end

  test 'with a selected value' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_locale_dropdown(
        attribute: :locale,
        label: 'Locale',
        resource: @resource,
        hidden: false,
        options: { readonly: false }
      )
    end

    assert_selector("#user_#{@resource.id}_locale--label", text: 'Locale')
    assert_selector("#user_#{@resource.id}_locale--input[value=\"English (GB)\"]")
    assert_selector("#user_#{@resource.id}_locale--hidden-input[value=\"en-GB\"]", visible: false)
    assert_selector("#user_#{@resource.id}_locale--button")
    assert_selector("span#user_#{@resource.id}_locale--#{@resource.locale}-checkmark")
  end

  test 'without a selected value' do
    @resource.locale = nil
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_locale_dropdown(
        attribute: :locale,
        label: 'Locale',
        resource: @resource,
        hidden: false,
        options: { readonly: false }
      )
    end

    assert_no_selector("span#user_#{@resource.id}_locale--#{@resource.locale}-checkmark")
  end

  test 'readonly mode' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_locale_dropdown(
        attribute: :locale,
        label: 'Locale',
        resource: @resource,
        options: { readonly: true }
      )
    end

    assert_no_selector("#user_#{@resource.id}_locale--button")
  end

  test 'with help text' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_locale_dropdown(
        attribute: :locale,
        label: 'Locale',
        resource: @resource,
        options: { readonly: false, help: 'This is some help' }
      )
    end

    assert_selector("#user_#{@resource.id}_locale--help", text: 'This is some help')
  end
end
