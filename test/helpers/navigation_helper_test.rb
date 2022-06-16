# frozen_string_literal: true

require 'test_helper'

# rubocop:disable Layout/TrailingWhitespace
class NavigationHelperTest < ActionView::TestCase
  include IconsHelper

  test 'active navigation link' do
    html = <<~HTML.squish
      <a class="bg-gray-900 text-white group flex items-center px-2 py-2 text-sm font-medium rounded-md" 
      href="/products"><svg class="text-gray-300 mr-3 flex-shrink-0 h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" 
      viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" 
      stroke-width="2" d="M8 14v3m4-3v3m4-3v3M3 21h18M3 10h18M3 7l9-4 9 4M4 10h16v11H4V10z"></path></svg>Products</a>
    HTML

    assert_dom_equal(html, render_sidenav_item(label: 'Products', icon: :library, link: products_path, active: true))
  end

  test 'inactive navigation link' do
    html = <<~HTML.squish
      <a class="text-gray-300 hover:bg-gray-700 hover:text-white group flex items-center px-2 py-2 text-sm font-medium rounded-md" 
      href="/products"><svg class="text-gray-400 group-hover:text-gray-300 mr-3 flex-shrink-0 h-6 w-6" 
      xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true"><path 
      stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
      d="M8 14v3m4-3v3m4-3v3M3 21h18M3 10h18M3 7l9-4 9 4M4 10h16v11H4V10z"></path></svg>Products</a>
    HTML

    assert_dom_equal(html, render_sidenav_item(label: 'Products', icon: :library, link: products_path, active: false))
  end
end
# rubocop:enable Layout/TrailingWhitespace
