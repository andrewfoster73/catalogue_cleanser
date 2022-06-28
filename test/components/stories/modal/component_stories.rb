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
          colour_classes: 'text-white bg-red-500 hover:bg-red-600 focus:ring-red-200',
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
  end
end
