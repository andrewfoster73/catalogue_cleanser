# frozen_string_literal: true

module ProductIssues
  class MissingCompulsory < ProductIssue
    class << self
      def issue?(product:, attribute:, product_translation: nil)
        # Attribute is nil or empty (including blank spaces)
        return !product.public_send(attribute).presence if product && !product_translation
        return !product_translation.public_send(attribute).presence if product_translation

        true
      end
    end

    private

    def automatic_confirmation?
      true
    end

    def build_resolution_task
      # Tasks::FixCompulsory.new
    end
  end
end
