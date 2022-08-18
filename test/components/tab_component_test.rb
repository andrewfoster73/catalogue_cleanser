# frozen_string_literal: true

require 'test_helper'

class Tab::ComponentTest < ViewComponent::TestCase
  test 'active with an icon and badge' do
    render_inline(
      Tab::Component.new(
        id: :tab_id,
        label: 'Audit',
        url: '#audit',
        active: true,
        options: {
          icon_options: { name: :folder_open, colour: :gray },
          badge_count: 5
        }
      )
    )

    assert_selector('a[href="#audit"]')
    assert_selector('a#tab_tab_id.text-gray-900.bg-sky-50')
    assert_selector('#tab_tab_id--icon svg')
    assert_selector('#tab_tab_id--label', text: 'Audit')
    assert_selector('#tab_tab_id--badge_count')
    assert_selector('#tab_tab_id--badge_count__integer', text: 5)
  end

  test 'inactive with an icon and badge' do
    render_inline(
      Tab::Component.new(
        id: :tab_id,
        label: 'Audit',
        url: '#audit',
        active: false,
        options: {
          icon_options: { name: :folder_open, colour: :gray },
          badge_count: 21
        }
      )
    )

    assert_selector('a[href="#audit"]')
    assert_selector('a#tab_tab_id.text-gray-500')
    assert_no_selector('a#tab_tab_id.text-gray-900.bg-sky-100')
    assert_selector('#tab_tab_id--icon svg')
    assert_selector('#tab_tab_id--label', text: 'Audit')
    assert_selector('#tab_tab_id--badge_count')
    assert_selector('#tab_tab_id--badge_count__integer', text: 21)
  end

  test 'badge only' do
    render_inline(
      Tab::Component.new(
        id: :tab_id,
        label: 'Audit',
        url: '#audit',
        active: false,
        options: {
          badge_count: 31
        }
      )
    )

    assert_selector('a[href="#audit"]')
    assert_selector('a#tab_tab_id.text-gray-500')
    assert_no_selector('#tab_tab_id--icon svg')
    assert_selector('#tab_tab_id--label', text: 'Audit')
    assert_selector('#tab_tab_id--badge_count')
    assert_selector('#tab_tab_id--badge_count__integer', text: 31)
  end

  test 'icon only' do
    render_inline(
      Tab::Component.new(
        id: :tab_id,
        label: 'Audit',
        url: '#audit',
        active: false,
        options: {
          icon_options: { name: :folder_open, colour: :gray }
        }
      )
    )

    assert_selector('a[href="#audit"]')
    assert_selector('a#tab_tab_id.text-gray-500')
    assert_selector('#tab_tab_id--icon svg')
    assert_selector('#tab_tab_id--label', text: 'Audit')
    assert_no_selector('#tab_tab_id--badge_count')
    assert_no_selector('#tab_tab_id--badge_count__integer', text: 21)
  end
end
