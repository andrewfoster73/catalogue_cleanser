# frozen_string_literal: true

module UserProfile
  class Component < ViewComponent::Base
    def initialize(user:)
      super
      @user = user
    end

    def gravatar_url
      "https://www.gravatar.com/avatar/#{gravatar_hash}?d=retro"
    end

    private

    def gravatar_hash
      Digest::MD5.hexdigest(@user.email)
    end
  end
end
