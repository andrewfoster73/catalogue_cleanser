# frozen_string_literal: true

module ResourceActions
  class ComponentStories < ApplicationStories
    story :show do
      button(
        id: 'resource_back',
        label: 'Back',
        options: {
          title: 'http::/example.com/collection',
          icon: { name: :arrow_left, colour: :white },
          colour_classes: 'text-white bg-indigo-600 hover:bg-indigo-700 focus:ring-indigo-200'
        }
      )
      button(
        id: 'resource_edit',
        label: 'Edit',
        options: {
          title: 'Edit',
          icon: { name: :pencil, colour: :white },
          colour_classes: 'text-white bg-amber-600 hover:bg-amber-700 focus:ring-amber-200'
        }
      )
    end

    story :edit do
      button(
        id: 'resource_back',
        label: 'Back',
        options: {
          title: 'http::/example.com/collection',
          icon: { name: :arrow_left, colour: :white },
          colour_classes: 'text-white bg-indigo-600 hover:bg-indigo-700 focus:ring-indigo-200'
        }
      )
      button(
        id: 'resource_update',
        label: 'Update',
        options: {
          icon: { name: :save, colour: :white },
          colour_classes: 'text-white bg-emerald-600 hover:bg-emerald-700 focus:ring-emerald-200'
        }
      )
      button(
        id: 'resource_delete',
        label: 'Delete',
        options: {
          icon: { name: :trash, colour: :white },
          colour_classes: 'text-white bg-red-500 hover:bg-red-600 focus:ring-red-200'
        }
      )
    end
  end
end
