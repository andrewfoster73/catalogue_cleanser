# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'valid user' do
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '12345',
      info: {
        first_name: 'Saul',
        last_name: 'Goodman',
        email: 'saul.goodman@example.com'
      }
    }
                                                                      )
    get '/auth/google_oauth2/callback'
    assert_redirected_to dashboard_url
  end

  test 'invalid user' do
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: 'wrong_uid',
      info: {
        first_name: 'Saul',
        last_name: 'Goodman',
        email: 'saul.goodman@example.com'
      }
    }
                                                                      )
    get '/auth/google_oauth2/callback'
    assert_redirected_to :root
  end

  test 'should destroy session' do
    authenticate
    delete sessions_logout_url
    assert_redirected_to :root
    assert_nil(session[:user_id], 'Log out did not clear session user_id')
  end
end
