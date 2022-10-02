# frozen_string_literal: true

module ResourceForm
  class ImageComponentStories < ApplicationStories
    story :basic do
      constructor(
        attribute: text('image_url'),
        label: text('Picture'),
        resource: klazz(User, email: 'saul.goodman@example.com')
      )
    end
  end
end
