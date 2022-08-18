# frozen_string_literal: true

require 'test_helper'

class TabNavigation::ComponentTest < ViewComponent::TestCase
  test 'with no tabs' do
    render_inline(TabNavigation::Component.new(id: :tab_navigation_id))
    assert_selector('div#tab_navigation--tab_navigation_id')
  end

  test 'with 2 tabs' do
    @parent = item_sell_packs(:carton)
    render_inline(TabNavigation::Component.new(id: :tab_navigation_id)) do |component|
      component.with_tab(
        id: :details,
        label: 'Details',
        url: '#details',
        active: false,
        options: { icon_options: { name: :library, colour: :gray } }
      )
      component.with_tab(
        id: :item_sell_pack_aliases,
        label: 'Aliases',
        url: '#',
        active: true,
        options: {
          parent: @parent,
          icon_options: { name: :folder_open, colour: :gray },
          badge_count: @parent.item_sell_pack_aliases.size
        }
      )
    end

    assert_selector('div#tab_navigation--tab_navigation_id')
    assert_selector('a#tab_details')
    assert_selector("a#tab_#{@parent.resource_name}_#{@parent.id}_item_sell_pack_aliases")

    assert_selector('a[href="#details"]')
    assert_selector('a#tab_details.text-gray-500')
    assert_selector('#tab_details--icon svg')
    assert_selector('#tab_details--label', text: 'Details')

    parent_tab_id = "#{@parent.resource_name}_#{@parent.id}_item_sell_pack_aliases"
    assert_selector('a[href="#"]')
    assert_selector("a#tab_#{parent_tab_id}.text-gray-900.bg-sky-50")
    assert_selector("#tab_#{parent_tab_id}--icon svg")
    assert_selector("#tab_#{parent_tab_id}--label", text: 'Aliases')
    assert_selector("#tab_#{parent_tab_id}--badge_count")
    assert_selector("#tab_#{parent_tab_id}--badge_count__integer", text: @parent.item_sell_pack_aliases.size)
  end
end
