# frozen_string_literal: true

module ResourceForm
  class ImageComponent < BaseComponent
    private

    def image_url
      resource.public_send(attribute)
    end
  end
end
