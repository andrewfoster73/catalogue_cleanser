# frozen_string_literal: true

module CollectionFilter
  class ListComponentStories < ApplicationStories
    story :none_selected do
      constructor(
        label: 'Actions',
        attribute: :action,
        options: [
          { text: 'Create', value: 'create' },
          { text: 'Update', value: 'update' },
          { text: 'Delete', value: 'delete' }
        ]
      )
    end
  end
end
