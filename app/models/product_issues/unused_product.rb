# frozen_string_literal: true

module ProductIssues
  class UnusedProduct < ProductIssue
    class << self
      def issue?(product:, product_translation: nil, **_other)
        # Translations don't need to be checked
        return false if product_translation
        # If the stats haven't been collected yet this cannot be confirmed
        return false if product.collected_statistics_at.nil?
        # All the usage stats are zero
        return !product.used? if product

        true
      end
    end

    def fix!
      update!(
        resolution_task_type: Tasks::DeleteExternalProduct
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
