# frozen_string_literal: true

module ResourceForm
  class NumberComponentStories < ApplicationStories
    story :item_size do
      constructor(
        attribute: :item_size,
        label: 'Item Size',
        resource: klazz(Product, item_size: text('2.5')),
        options: { readonly: false, required: true, min: 0.0, step: 0.0001, invalid_message: I18n.t('products.resource.invalid_message.item_size') }
      )
    end
  end
end
