# frozen_string_literal: true

module UserProfile
  class ComponentStories < ApplicationStories
    story :saul_goodman do
      constructor(user: User.new(full_name: 'Saul Goodman', email: 'saul.goodman@example.com'))
    end
  end
end
