# frozen_string_literal: true

require 'test_helper'

class CollectionFilter::ToggleComponentTest < ViewComponent::TestCase
  test 'rendering' do
    render_inline(
      CollectionFilter::ToggleComponent.new(
        label: 'Canonical',
        attribute: :canonical
      )
    )

    assert_selector('label', text: 'Canonical')
    assert_selector('input#q_canonical_true[name="q[canonical_true]"]', visible: false)
    assert_selector('input#q_canonical_not_true[name="q[canonical_not_true]"]', visible: false)
    assert_selector('button#toggle_canonical')
  end
end
