# frozen_string_literal: true

require 'application_system_test_case'

class SidebarTest < ApplicationSystemTestCase
  test 'logo' do
    visit products_url

    within('#side_bar') do
      assert_selector(:css, '#side_bar--logo')
    end
  end

  test 'navigation' do
    visit products_url

    within('#side_bar') do
      assert_selector(:css, '#side_bar--navigation')
    end
  end

  test 'user profile' do
    visit products_url

    within('#side_bar') do
      assert_selector(:css, '#side_bar--user_profile')
    end
  end
end
