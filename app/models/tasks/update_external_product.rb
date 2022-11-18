# frozen_string_literal: true

module Tasks
  class UpdateExternalProduct < Task
    class << self
      def executable?(changed_attributes)
        (changed_attributes.keys & updatable_attributes).any?
      end

      def updatable_attributes
        %w[
          brand item_description item_size item_measure item_pack_name item_sell_quantity item_sell_pack_name
          volume_in_litres category_id
        ]
      end
    end

    def initialize(attributes = nil)
      super
      self.description = 'Update a P+ product using the attributes from an updated local product'
    end

    protected

    def execute
      # Option 1 - Write changes directly
      assign_attributes(before: context.external_product.attributes.slice(*updatable_attributes))
      context.external_product.lock!.update!(context.attributes.slice(*updatable_attributes))
      assign_attributes(after: context.external_product.reload.attributes.slice(*updatable_attributes))

      # Option 2 - Call P+ API to update product
    rescue ActiveRecord::NotNullViolation => e
      self.error = e.full_message
      self.backtrace = e.backtrace
      error!
    end

    private

    def updatable_attributes
      self.class.updatable_attributes
    end
  end
end
