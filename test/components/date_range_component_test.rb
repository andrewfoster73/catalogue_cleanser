# frozen_string_literal: true

require 'test_helper'

class CollectionFilter::DateRangeComponentTest < ViewComponent::TestCase
  test 'rendering' do
    render_inline(CollectionFilter::DateRangeComponent.new(attribute: :created_at))

    assert_selector('label[for="q_created_at_gteq"]', text: 'Created at is on or after')
    assert_selector('input#q_created_at_gteq[name="q[created_at_gteq]"]')
    assert_selector('label[for="q_created_at_lteq"]', text: 'Created at is on or before')
    assert_selector('input#q_created_at_lteq[name="q[created_at_lteq]"]')
  end
end
