# frozen_string_literal: true

require 'test_helper'

class ResourceForm::ImageComponentTest < ViewComponent::TestCase
  def setup
    @resource = users(:saul)
  end

  test 'readonly mode' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_image(attribute: :image_url, label: 'Picture', resource: @resource)
    end

    assert_selector("#user_#{@resource.id}_image_url--label")
    assert_selector("label[for=\"user_#{@resource.id}_image_url\"]", text: 'Picture')
    assert_selector("span#user_#{@resource.id}_image_url--image img")
  end

  test 'with help text' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_image(
        attribute: :image_url,
        label: 'Picture',
        resource: @resource,
        options: { readonly: true, help: 'This is a help message' }
      )
    end

    assert_selector("#user_#{@resource.id}_image_url--help", text: 'This is a help message')
  end
end
