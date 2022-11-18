# frozen_string_literal: true

module ProductIssues
  class AdditionalWhitespace < ProductIssue
    class << self
      def issue?(product:, attribute:, product_translation: nil)
        return true unless product || product_translation
        return attribute_has_whitespace?(resource: product_translation, attribute: attribute) if product_translation

        attribute_has_whitespace?(resource: product, attribute: attribute)
      end

      private

      def attribute_has_whitespace?(resource:, attribute:)
        # Do not allow leading, trailing or multiple spaces
        resource.public_send(attribute)&.squeeze(' ')&.strip != resource.public_send(attribute)
      end
    end

    def fix!
      update!(
        resolution_suggested_replacement: parent.public_send(test_attribute)&.squeeze(' ')&.strip,
        resolution_task_type: Tasks::StripWhitespace
      )
      super
    end

    private

    def automatic_confirmation?
      true
    end

    def create_resolution_task
      resolution_task_type.safe_constantize.create!(context: parent, product_issue: self)
    end
  end
end
