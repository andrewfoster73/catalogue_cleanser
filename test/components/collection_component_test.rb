# frozen_string_literal: true

require 'test_helper'

class Collection::ComponentTest < ViewComponent::TestCase
  Paginator = Struct.new(:next, keyword_init: true)
  private_constant :Paginator

  test 'renders' do
    render_inline(Collection::Component.new) do |component|
      component.header(columns: [{ label: 'Title' }])
      component.pager(paginator: Paginator.new(next: 2), collection_path_method: :item_sell_packs_path)
    end

    assert_selector('#collection_header th', text: 'Title')
    assert_selector('#collection_pager a', text: 'Load More')
    assert_selector('tfoot tr td', text: 'There are no records.')
    assert_selector('tfoot tr td[colspan="2"]')
  end
end
