# frozen_string_literal: true

require 'test_helper'

class UserProfileComponentTest < ViewComponent::TestCase
  def setup
    @user = build(:user, full_name: 'Saul Goodman', email: 'saul.goodman@example.com')
  end

  test 'renders full name' do
    assert_equal(
      %(<p id="user_profile_name" class="text-sm font-medium text-white">Saul Goodman</p>),
      render_inline(UserProfileComponent.new(user: @user)).css('#user_profile_name').to_html
    )
  end

  test 'renders gravatar image' do
    assert_equal(
      %(<img class="inline-block h-12 w-12 rounded-full" alt="Saul Goodman" src="https://www.gravatar.com/avatar/57595bd63983cd9dae1f8ffe9d286c52?d=retro">),
      render_inline(UserProfileComponent.new(user: @user)).css('#user_profile_image img').to_html
    )
  end
end
