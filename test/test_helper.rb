# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
require_relative '../config/environment'
require 'rails/test_help'

OmniAuth.config.test_mode = true

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # DOES NOT WORK WITH SimpleCov
  # parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryBot::Syntax::Methods
end

# Capybara login
def login
  mock_authentication
  visit(root_url)
  click_on('Log in with Google')
end

# Controller login
def authenticate
  mock_authentication
  get('/auth/google_oauth2/callback')
end

def mock_authentication
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
    {
      provider: 'google_oauth2',
      uid: '12345',
      info: {
        first_name: 'Saul',
        last_name: 'Goodman',
        email: 'saul.goodman@example.com'
      }
    }
  )
end
