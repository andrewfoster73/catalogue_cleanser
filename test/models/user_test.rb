# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'first name presence validation' do
    user = build(:user, first_name: nil, email: 'test@test.com')
    assert_not(user.save, 'Saved the user without required attributes')
  end

  test 'email presence validation' do
    user = build(:user, first_name: 'Bob', email: nil)
    assert_not(user.save, 'Saved the user without required attributes')
  end

  test 'email uniqueness validation' do
    # NOTE: there is a User with an email of 'saul.goodman@example.com' already in the fixtures
    user = build(:user, first_name: 'Bob', email: 'saul.goodman@example.com')
    assert_not(user.save, 'Saved the user using a duplicate email')
  end

  test 'finding an existing user from omniauth credentials' do
    omniauth_response = {
      provider: 'google_oauth2',
      uid: '12345',
      info: {
        first_name: 'Saul',
        last_name: 'Goodman',
        email: 'saul.goodman@example.com'
      }
    }
    assert_equal(
      users(:saul).id,
      User.from_omniauth(omniauth_response).id,
      'Saul Goodman user was not found using provider and uid'
    )
  end

  test 'creating a new user from omniauth credentials' do
    omniauth_response = {
      provider: 'google_oauth2',
      uid: '1234567890',
      info: {
        first_name: 'Barry',
        last_name: 'Tester',
        email: 'barry.tester@example.com',
        image: 'http://images.com'
      }
    }
    assert_changes(-> { User.count }, from: User.count, to: User.count + 1) do
      User.from_omniauth(omniauth_response)
    end
    user = User.find_by(provider: 'google_oauth2', uid: '1234567890')
    assert_equal('Barry', user.first_name, 'First name should be Barry')
    assert_equal('Tester', user.last_name, 'Last name should be Tester')
    assert_equal('barry.tester@example.com', user.email, 'Email should be barry.tester@example.com')
    assert_equal('http://images.com', user.picture_url, 'Picture URL should be http://images.com')
  end

  test 'full name' do
    user = users(:saul)
    assert_equal('Saul Goodman', user.full_name, 'Full name should be First Last')
  end

  test 'to_s' do
    user = users(:saul)
    assert_equal('Saul Goodman (saul.goodman@example.com)', user.to_s, 'to_s should be First Last (email)')
  end
end
