# frozen_string_literal: true

module ProductIssues
  class AllUppercase < ProductIssue
    class << self
      def issue?(product:, attribute:, product_translation: nil)
        # Attribute is all upper case characters
        return all_uppercase?(resource: product, attribute: attribute) if product && !product_translation
        return all_uppercase?(resource: product_translation, attribute: attribute) if product_translation

        true
      end

      private

      def all_uppercase?(resource:, attribute:)
        return false if resource.public_send(attribute)&.strip.blank?
        return false if resource.public_send(attribute).count('a-zA-Z').zero?

        resource.public_send(attribute) == resource.public_send(attribute).upcase
      end
    end
  end
end
