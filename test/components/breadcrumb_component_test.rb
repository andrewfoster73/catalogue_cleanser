# frozen_string_literal: true

require 'test_helper'

class Breadcrumb::ComponentTest < ViewComponent::TestCase
  test 'active' do
    render_inline(
      Breadcrumb::Component.new(
        id: :id,
        label: 'carton',
        url: '#carton',
        active: true
      )
    )

    assert_selector('a[href="#carton"]')
    assert_selector('a#breadcrumb_id--link.text-sky-500')
    assert_selector('p#breadcrumb_id--link_label', text: 'carton')
  end

  test 'inactive' do
    render_inline(
      Breadcrumb::Component.new(
        id: :id,
        label: 'Item Sell Packs',
        url: '#item_sell_packs'
      )
    )

    assert_selector('a[href="#item_sell_packs"]')
    assert_selector('a#breadcrumb_id--link.text-gray-500')
    assert_selector('p#breadcrumb_id--link_label', text: 'Item Sell Packs')
  end
end
