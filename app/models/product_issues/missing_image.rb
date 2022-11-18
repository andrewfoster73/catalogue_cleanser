# frozen_string_literal: true

module ProductIssues
  class MissingImage < ProductIssue
    class << self
      def issue?(product:, attribute: :image_file_name, product_translation: nil)
        # Translations don't need images
        return false if product_translation
        # Attribute is nil or empty (including blank spaces)
        return product.public_send(attribute)&.strip.blank? if product

        # TODO: Maybe also check if image is where it is supposed to be at S3

        true
      end
    end

    private

    def automatic_confirmation?
      true
    end
  end
end
