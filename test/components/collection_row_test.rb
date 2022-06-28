# frozen_string_literal: true

require 'test_helper'

class CollectionRow::ComponentTest < ViewComponent::TestCase
  test 'rendering' do
    render_inline(CollectionRow::Component.new(id: :the_id)) do |component|
      component.with_body { 'Row Body' }
    end

    assert_selector('#the_id', text: 'Row Body')
    assert_selector('tr.collection-rows__row')
  end
end
