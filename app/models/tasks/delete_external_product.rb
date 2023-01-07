# frozen_string_literal: true

module Tasks
  class DeleteExternalProduct < Task
    def initialize(attributes = nil)
      super
      self.description = 'Delete a P+ product'
    end

    protected

    def execute
      # Option 1 - Execute deletion directly
      Audited.audit_class.as_user("task-delete-external-product-#{id}") do
        context.external_product.lock!.destroy!
        context.lock!.discard!
        product_issue.fixed!
      end

      # Option 2 - Call P+ API to delete product
    rescue StandardError => e
      self.error = e.full_message
      self.backtrace = e.backtrace
      error!
      raise(e)
    end
  end
end
