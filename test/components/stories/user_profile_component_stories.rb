# frozen_string_literal: true

class UserProfileComponentStories < ViewComponent::Storybook::Stories
  story :saul_goodman do
    layout 'stories'
    constructor(user: User.new(full_name: 'Saul Goodman', email: 'saul.goodman@example.com'))
  end
end
