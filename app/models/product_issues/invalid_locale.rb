# frozen_string_literal: true

module ProductIssues
  class InvalidLocale < ProductIssue
    class << self
      def issue?(product:, attribute:, product_translation: nil)
        # Locale must one of the supported locales
        return valid_values.exclude?(product.public_send(attribute).strip.downcase) if product && !product_translation
        return valid_values.exclude?(product_translation.public_send(attribute).strip.downcase) if product_translation

        true
      end

      private

      def valid_values
        ProductTranslation.supported_locales_alpha2s
      end
    end

    private

    def automatic_confirmation?
      true
    end
  end
end
