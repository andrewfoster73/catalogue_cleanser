# frozen_string_literal: true

module Modal
  class ComponentStories < ApplicationStories
    story :delete_confirmation do
      constructor(name: :delete_confirmation, hidden: false)
      confirmation(
        title: 'Delete',
        icon_options: { name: :exclamation, colour: :red, options: { classes: '' } },
        message: 'Are you sure you want to delete this? This action cannot be undone.'
      )
      button(
        id: :confirm_delete,
        label: 'Delete',
        options: {
          icon: { name: :trash, colour: :white },
          colour_classes: 'text-white bg-rose-500 hover:bg-rose-600 focus:ring-rose-200',
          data: {
            params: [
              { name: 'resource-id', value: 57 },
              { name: 'resource-url', value: 'collection' },
              { name: 'resource-modal-name', value: :delete_confirmation }
            ],
            action: 'click->resource#delete'
          }
        }
      )
    end

    story :item_sell_packs_new do
      constructor(name: :item_sell_packs_new, hidden: false)
      form do
        render(
          partial: 'item_sell_packs/resource',
          locals: { action: :new, resource: ItemSellPack.new, readonly: false, token: 'token' }
        )
      end
      button(
        id: :save_new,
        label: 'Save',
        options: {
          icon: { name: :save, colour: :white },
          colour_classes: 'text-white bg-emerald-600 hover:bg-emerald-700 focus:ring-emerald-200',
          data: {
            params: [
              { name: 'resource-url', value: '/item_sell_packs' },
              { name: 'resource-form-id', value: 'form_item_sell_pack' },
              { name: 'resource-modal-name', value: :item_sell_packs_new }
            ],
            action: 'click->resource#create'
          }
        }
      )
    end
  end
end
