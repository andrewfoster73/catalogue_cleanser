# frozen_string_literal: true

require 'test_helper'

class ResourceActions::ComponentTest < ViewComponent::TestCase
  test 'rendering' do
    render_inline(ResourceActions::Component.new) do |component|
      component.with_button(
        id: :back,
        label: 'Back',
        options: {
          title: :back,
          icon: { name: :arrow_left, colour: :white },
          colour_classes: 'text-white bg-sky-600 hover:bg-sky-700 focus:ring-sky-200',
          data: {
            params: [{ name: 'resource-url', value: :back }],
            action: 'click->resource#navigate'
          }
        }
      )
    end

    assert_selector('#resource_actions--buttons')
    assert_selector('#back', text: 'Back')
    assert_selector('button[data-action="click->resource#navigate"]')
    assert_selector('button[data-resource-url-param="back"]')
  end
end
