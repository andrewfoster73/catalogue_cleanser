# frozen_string_literal: true

require 'test_helper'

class CollectionRow::ComponentTest < ViewComponent::TestCase
  test 'rendering' do
    render_inline(CollectionRow::Component.new) do |component|
      component.with_body { 'Row Body' }
    end

    assert_text('Row Body')
  end
end
