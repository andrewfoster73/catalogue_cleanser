# frozen_string_literal: true

module Tasks
  class MapExternalProduct < Task
    def initialize(attributes = nil)
      super
      self.description = 'Map a P+ product for replacement indicating which product is canonical'
    end

    protected

    def execute
      # The product may have been deleted as an unused product
      return unless context.external_product

      # Option 1 - Write changes directly
      assign_attributes(before: context.external_product.attributes.slice(*%w[canonical_product_id]))
      context.external_product.lock!.update!(canonical_product_id: context.canonical_product_id)
      assign_attributes(after: context.external_product.reload.attributes.slice(*%w[canonical_product_id]))

      # Option 2 - Call P+ API to update product
    end
  end
end
