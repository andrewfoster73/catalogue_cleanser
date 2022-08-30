# frozen_string_literal: true

require 'test_helper'

class CollectionFilter::ContainsComponentTest < ViewComponent::TestCase
  test 'rendering' do
    render_inline(
      CollectionFilter::ContainsComponent.new(
        label: 'Name contains',
        attribute: :name
      )
    )

    assert_selector('label', text: 'Name contains')
    assert_selector('input#filter_name[name="q[name_cont]"]')
  end
end
