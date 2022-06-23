# frozen_string_literal: true

require 'test_helper'
require 'ransack/helpers/form_helper'

class CollectionFilter::ComponentTest < ViewComponent::TestCase
  test 'renders item_sell_packs filters' do
    with_controller_class ItemSellPacksController do
      render_inline(CollectionFilter::Component.new(filter: ItemSellPack.ransack({})))
    end

    assert_selector('#item_sell_pack_search')
    assert_selector('label', text: 'Name contains')
    assert_selector('input#filter_name')
    assert_selector('label', text: 'Canonical')
    assert_selector('button#toggle_canonical')
  end
end
