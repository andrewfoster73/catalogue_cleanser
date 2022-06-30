# frozen_string_literal: true

module Button
  class ComponentStories < ApplicationStories
    story :neutral do
      constructor(
        id: 'resource_back',
        label: 'Back',
        options: {
          title: 'http::/example.com/collection',
          icon: { name: :arrow_left, colour: :white },
          colour_classes: 'text-white bg-sky-600 hover:bg-sky-700 focus:ring-sky-200'
        }
      )
    end

    story :danger do
      constructor(
        id: 'resource_delete',
        label: 'Delete',
        options: {
          icon: { name: :trash, colour: :white },
          colour_classes: 'text-white bg-rose-500 hover:bg-rose-600 focus:ring-rose-200'
        }
      )
    end

    story :go do
      constructor(
        id: 'resource_update',
        label: 'Update',
        options: {
          icon: { name: :save, colour: :white },
          colour_classes: 'text-white bg-emerald-600 hover:bg-emerald-700 focus:ring-emerald-200'
        }
      )
    end

    story :action do
      constructor(
        id: 'resource_edit',
        label: 'Edit',
        options: {
          title: 'Edit',
          icon: { name: :pencil, colour: :white },
          colour_classes: 'text-white bg-amber-600 hover:bg-amber-700 focus:ring-amber-200'
        }
      )
    end
  end
end
