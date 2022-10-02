# frozen_string_literal: true

require 'test_helper'

class ResourceForm::CountryDropdownComponentTest < ViewComponent::TestCase
  def setup
    @resource = users(:saul)
  end

  test 'with a selected value' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_country_dropdown(
        attribute: :country_alpha2,
        label: 'Country',
        resource: @resource,
        hidden: false,
        options: { readonly: false }
      )
    end

    assert_selector("#user_#{@resource.id}_country_alpha2--label", text: 'Country')
    assert_selector("#user_#{@resource.id}_country_alpha2--input[value=\"Australia\"]")
    assert_selector("#user_#{@resource.id}_country_alpha2--hidden-input[value=\"AU\"]", visible: false)
    assert_selector("#user_#{@resource.id}_country_alpha2--button")
    assert_selector("span#user_#{@resource.id}_country_alpha2--#{@resource.country_alpha2}-checkmark")
  end

  test 'without a selected value' do
    @resource.country_alpha2 = nil
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_country_dropdown(
        attribute: :country_alpha2,
        label: 'Country',
        resource: @resource,
        hidden: false,
        options: { readonly: false }
      )
    end

    assert_no_selector("span#user_#{@resource.id}_country_alpha2--#{@resource.country_alpha2}-checkmark")
  end

  test 'readonly mode' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_country_dropdown(
        attribute: :country_alpha2,
        label: 'Country',
        resource: @resource,
        options: { readonly: true }
      )
    end

    assert_no_selector("#user_#{@resource.id}_country_alpha2--button")
  end

  test 'with help text' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_country_dropdown(
        attribute: :country_alpha2,
        label: 'Country',
        resource: @resource,
        options: { readonly: false, help: 'This is some help' }
      )
    end

    assert_selector("#user_#{@resource.id}_country_alpha2--help", text: 'This is some help')
  end
end
