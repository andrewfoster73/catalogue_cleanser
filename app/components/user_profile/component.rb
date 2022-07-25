# frozen_string_literal: true

module UserProfile
  class Component < ViewComponent::Base
    include IconsHelper

    def initialize(user:)
      super
      @user = user
    end

    def picture_url
      @user.picture_url.presence || gravatar_url
    end

    def logout_link
      link_to(
        sessions_logout_path,
        id: 'user_profile--logout',
        data: { turbo_method: :delete },
        class: 'inline-flex items-center text-xs font-medium text-gray-300 group-hover:text-gray-200'
      ) do
        'Logout'
      end
    end

    private

    def gravatar_url
      "https://www.gravatar.com/avatar/#{gravatar_hash}?d=retro"
    end

    def gravatar_hash
      Digest::MD5.hexdigest(@user.email)
    end
  end
end
