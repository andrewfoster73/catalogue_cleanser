# frozen_string_literal: true

module ProductIssues
  class PotentialDuplication < ProductIssue
    class << self
      def issue?(product:, product_translation: nil, **_other)
        # Translations don't need to be checked
        return false if product_translation
        # If the stats haven't been collected yet this cannot be confirmed
        return false if product.duplication_certainty.nil?

        product.duplication_certainty > ProductDuplicate::MINIMUM_CERTAINTY_PERCENTAGE
      end
    end

    def fix!
      update!(
        resolution_task_type: Tasks::MapExternalProduct
      )
      super
    end

    private

    def create_resolution_task
      resolution_task_type.safe_constantize.create!(context: parent, product_issue: self, requires_approval: true)
    end
  end
end
