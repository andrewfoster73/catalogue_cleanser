# frozen_string_literal: true

require 'test_helper'

class CollectionPager::ComponentTest < ViewComponent::TestCase
  Paginator = Struct.new(:next, keyword_init: true)
  private_constant :Paginator

  # rubocop:disable Layout/LineLength
  test 'renders pager button when there is a next page' do
    assert_equal(
      %(<div id="collection_pager" class="min-w-full my-8 flex justify-between">
  <a class="inline-flex items-center justify-center rounded-md border border-transparent bg-indigo-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 sm:w-auto" data-turbo-frame="page_handler" data-controller="collection-pager--component" href="/item_sell_packs?page=2">Load More</a>
</div>),
      render_inline(
        CollectionPager::Component.new(paginator: Paginator.new(next: 2), collection_path_method: :item_sell_packs_path)
      ).css('#collection_pager').to_html
    )
  end
  # rubocop:enable Layout/LineLength

  test 'renders empty when there is no next page' do
    assert_equal(
      %(),
      render_inline(
        CollectionPager::Component.new(paginator: Paginator.new(next: nil),
                                       collection_path_method: :item_sell_packs_path
                                      )
      ).css('#collection_pager').to_html
    )
  end
end