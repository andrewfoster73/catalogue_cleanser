# frozen_string_literal: true

require 'test_helper'

# rubocop:disable Layout/TrailingWhitespace
class IconsHelperTest < ActionView::TestCase
  test 'icon with default settings' do
    svg_html = <<~HTML.squish
      <svg class="text-gray-400 group-hover:text-gray-300 mr-3 flex-shrink-0 h-6 w-6" 
      xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true"><path 
      stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
      d="M8 14v3m4-3v3m4-3v3M3 21h18M3 10h18M3 7l9-4 9 4M4 10h16v11H4V10z"></path></svg>
    HTML

    assert_dom_equal(svg_html, icon(name: :library, colour: :gray))
  end

  test 'icon that is active' do
    svg_html = <<~HTML.squish
      <svg class="text-yellow-300 mr-3 flex-shrink-0 h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" 
      viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" 
      stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-6l-2-2H5a2 2 0 00-2 2z"></path></svg>
    HTML

    assert_dom_equal(svg_html, icon(name: :folder, colour: :yellow, active: true))
  end

  test 'icon with a different size' do
    svg_html = <<~HTML.squish
      <svg class="text-red-400 group-hover:text-red-300 mr-3 flex-shrink-0 h-9 w-9" xmlns="http://www.w3.org/2000/svg" 
      fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true"><path stroke-linecap="round" 
      stroke-linejoin="round" stroke-width="2"
      d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
    HTML

    assert_dom_equal(svg_html, icon(name: :trash, colour: :red, size: 9))
  end
end
# rubocop:enable Layout/TrailingWhitespace
