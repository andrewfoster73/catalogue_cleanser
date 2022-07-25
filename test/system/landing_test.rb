# frozen_string_literal: true

require 'application_system_test_case'

class LandingTest < ApplicationSystemTestCase
  test 'visiting the landing page' do
    visit root_url
    assert_selector('button#landing_login-button', text: 'Log in with Google')
  end
end
