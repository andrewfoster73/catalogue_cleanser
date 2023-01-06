# frozen_string_literal: true

module Tasks
  class UpdateExternalProductTranslation < Task
    class << self
      def executable?(changed_attributes)
        (changed_attributes.keys & updatable_attributes).any?
      end

      def updatable_attributes
        %w[
          brand item_description item_size item_measure item_pack_name item_sell_quantity item_sell_pack_name
        ]
      end
    end

    def initialize(attributes = nil)
      super
      self.description =
        'Update a P+ product translation using the attributes from an updated local product translation'
    end

    protected

    def execute
      # The product (and therefore translation) may have been deleted as an unused product
      return unless context.external_product_translation

      # Option 1 - Write changes directly
      assign_attributes(before: context.external_product_translation.attributes.slice(*updatable_attributes))
      context.external_product_translation.lock!.update!(context.attributes.slice(*updatable_attributes))
      assign_attributes(after: context.external_product_translation.reload.attributes.slice(*updatable_attributes))

      # Option 2 - Call P+ API to update product
    end

    private

    def updatable_attributes
      self.class.updatable_attributes
    end
  end
end
