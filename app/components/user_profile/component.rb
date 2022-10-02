# frozen_string_literal: true

module UserProfile
  class Component < ViewComponent::Base
    include IconsHelper

    attr_accessor :user

    def initialize(user:)
      super
      @user = user
    end

    private

    def edit_profile_link
      link_to(
        edit_user_path(user),
        id: 'user_profile--edit_profile'
      ) do
        t('user_profile.component.edit_profile')
      end
    end

    def logout_link
      link_to(
        sessions_logout_path,
        id: 'user_profile--logout',
        data: { turbo_method: :delete },
        class: 'inline-flex items-center text-xs font-medium text-gray-300 group-hover:text-gray-200'
      ) do
        t('user_profile.component.logout')
      end
    end
  end
end
