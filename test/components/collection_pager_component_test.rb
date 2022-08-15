# frozen_string_literal: true

require 'test_helper'

class CollectionPager::ComponentTest < ViewComponent::TestCase
  Paginator = Struct.new(:next, keyword_init: true)
  private_constant :Paginator

  # rubocop:disable Layout/LineLength
  test 'renders pager button when there is a next page' do
    assert_equal(
      %(<div id="collection_pager" class="min-w-full my-8 flex justify-between">
  <a class="inline-flex items-center justify-center rounded-md border border-transparent bg-sky-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-sky-700 focus:outline-none focus:ring-2 focus:ring-sky-500 focus:ring-offset-2 sm:w-auto" data-turbo-frame="page_handler" data-controller="collection-pager--component" href="/item_sell_packs?page=2">Load More</a>
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
        CollectionPager::Component.new(
          paginator: Paginator.new(next: nil),
          collection_path_method: :item_sell_packs_path
        )
      ).css('#collection_pager').to_html
    )
  end

  # rubocop:disable Layout/LineLength
  test 'renders filtering and sorting parameters in link' do
    params = ActionController::Parameters.new(
      { q: { name_cont: 'test' } }
    )

    assert_equal(
      %(<div id="collection_pager" class="min-w-full my-8 flex justify-between">
  <a class="inline-flex items-center justify-center rounded-md border border-transparent bg-sky-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-sky-700 focus:outline-none focus:ring-2 focus:ring-sky-500 focus:ring-offset-2 sm:w-auto" data-turbo-frame="page_handler" data-controller="collection-pager--component" href="/item_sell_packs?page=2&amp;q%5Bq%5D%5Bname_cont%5D=test">Load More</a>
</div>),
      render_inline(
        CollectionPager::Component.new(
          paginator: Paginator.new(next: 2),
          collection_path_method: :item_sell_packs_path,
          filter_params: params
        )
      ).css('#collection_pager').to_html
    )
  end
  # rubocop:enable Layout/LineLength

  # rubocop:disable Layout/LineLength
  test 'generates correct link for nested content' do
    params = ActionController::Parameters.new(
      { q: { name_cont: 'test' } }
    )

    assert_equal(
      %(<div id="collection_pager" class="min-w-full my-8 flex justify-between">
  <a class="inline-flex items-center justify-center rounded-md border border-transparent bg-sky-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-sky-700 focus:outline-none focus:ring-2 focus:ring-sky-500 focus:ring-offset-2 sm:w-auto" data-turbo-frame="page_handler" data-controller="collection-pager--component" href="/item_sell_packs/#{item_sell_packs(:carton).id}/item_sell_pack_aliases?page=2&amp;q%5Bq%5D%5Bname_cont%5D=test">Load More</a>
</div>),
      render_inline(
        CollectionPager::Component.new(
          paginator: Paginator.new(next: 2),
          collection_path_method: :item_sell_pack_item_sell_pack_aliases_path,
          parent_param: item_sell_packs(:carton),
          filter_params: params
        )
      ).css('#collection_pager').to_html
    )
  end
  # rubocop:enable Layout/LineLength
end
