# frozen_string_literal: true

require 'test_helper'

class Collection::ComponentTest < ViewComponent::TestCase
  Paginator = Struct.new(:next, keyword_init: true)
  private_constant :Paginator

  test 'renders' do
    render_inline(Collection::Component.new) do |component|
      component.header(columns: [{ label: 'Title' }])
      component.rows do |c|
        c.row(id: '1')
        c.row(id: '2')
      end
      component.pager(paginator: Paginator.new(next: 2), collection_path_method: :item_sell_packs_path)
    end

    assert_selector('#collection_header th', text: 'Title')
    assert_selector('tr#1.collection-rows__row')
    assert_selector('tr#2.collection-rows__row')
    assert_selector('#collection_pager a', text: 'Load More')
  end
end
