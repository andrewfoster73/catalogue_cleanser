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
      context.external_product.destroy!
      context.discard!

      # Option 2 - Call P+ API to delete product
    rescue StandardError => e
      self.error = e.full_message
      self.backtrace = e.backtrace
      error!
      raise(e)
    end
  end
end
