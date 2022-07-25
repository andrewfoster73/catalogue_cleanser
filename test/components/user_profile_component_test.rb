# frozen_string_literal: true

require 'test_helper'

class UserProfile::ComponentTest < ViewComponent::TestCase
  def setup
    @user = users(:saul)
  end

  test 'renders full name' do
    assert_equal(
      %(<p id="user_profile--name" class="text-sm font-medium text-white">Saul Goodman</p>),
      render_inline(UserProfile::Component.new(user: @user)).css('#user_profile--name').to_html
    )
  end

  test 'renders gravatar image' do
    assert_equal(
      %(<img class="inline-block h-12 w-12 rounded-full" alt="Saul Goodman" referrerpolicy="no-referrer" src="https://www.gravatar.com/avatar/57595bd63983cd9dae1f8ffe9d286c52?d=retro">),
      render_inline(UserProfile::Component.new(user: @user)).css('#user_profile--image img').to_html
    )
  end

  test 'renders picture URL image' do
    user = users(:saul).tap { |u| u.picture_url = 'http://picture.com' }
    assert_equal(
      %(<img class="inline-block h-12 w-12 rounded-full" alt="Saul Goodman" referrerpolicy="no-referrer" src="http://picture.com">),
      render_inline(UserProfile::Component.new(user: user)).css('#user_profile--image img').to_html
    )
  end

  # rubocop:disable Layout/LineLength
  test 'renders logout link' do
    assert_equal(
      %(<a id="user_profile--logout" data-turbo-method="delete" class="inline-flex items-center text-xs font-medium text-gray-300 group-hover:text-gray-200" href="/sessions/logout">Logout</a>),
      render_inline(UserProfile::Component.new(user: @user)).css('#user_profile--logout').to_html
    )
  end
  # rubocop:enable Layout/LineLength
end
