# frozen_string_literal: true

require 'test_helper'

class Collection::ComponentTest < ViewComponent::TestCase
  Paginator = Struct.new(:next, keyword_init: true)
  private_constant :Paginator

  test 'renders' do
    render_inline(Collection::Component.new) do |component|
      component.header(columns: [{ name: 'Title' }])
      component.rows do |c|
        c.row { 'This is a row' }
        c.row { 'This is another row' }
      end
      component.pager(paginator: Paginator.new(next: 2), collection_path_method: :item_sell_packs_path)
    end

    assert_selector('#collection_header th', text: 'Title')
    assert_selector('tr.collection-rows__row', text: 'This is a row')
    assert_selector('tr.collection-rows__row', text: 'This is another row')
    assert_selector('#collection_pager a', text: 'Load More')
  end
end
