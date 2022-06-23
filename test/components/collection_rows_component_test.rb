# frozen_string_literal: true

require 'test_helper'

class CollectionRows::ComponentTest < ViewComponent::TestCase
  test 'renders' do
    render_inline(CollectionRows::Component.new) do |component|
      component.row { 'This is a row' }
    end

    assert_selector('tr.collection-rows__row', text: 'This is a row')
  end
end
