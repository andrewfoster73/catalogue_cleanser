# frozen_string_literal: true

require 'test_helper'

class CollectionRows::ComponentTest < ViewComponent::TestCase
  test 'renders' do
    render_inline(CollectionRows::Component.new) do |component|
      component.row(id: '1')
    end

    assert_selector('tr.collection-rows__row')
    assert_selector('#1')
  end
end
