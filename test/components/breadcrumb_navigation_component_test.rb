# frozen_string_literal: true

require 'test_helper'

class BreadcrumbNavigation::ComponentTest < ViewComponent::TestCase
  test 'home' do
    render_inline(BreadcrumbNavigation::Component.new(id: :id))

    assert_selector('a[href="/"]')
    assert_selector('a#breadcrumb_navigation_id--home.text-gray-400')
    assert_selector('#breadcrumb_navigation_id--home svg')
  end
end
