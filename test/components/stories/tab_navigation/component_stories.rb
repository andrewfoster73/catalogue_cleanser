# frozen_string_literal: true

module TabNavigation
  class ComponentStories < ApplicationStories
    story :resource_tabs do
      constructor(id: 'tab_navigation')
      tab(
        id: :details,
        label: 'Details',
        url: '#details',
        active: false,
        options: { icon_options: { name: :library, colour: :gray } }
      )
      tab(
        id: 'tab',
        label: text('Lines'),
        url: '#lines',
        active: true,
        options: {
          icon_options: { name: :folder_open, colour: :gray },
          badge_count: 21
        }
      )
      tab(
        id: 'tab',
        label: text('Audit'),
        url: '#audit',
        active: false,
        options: {
          icon_options: { name: :database, colour: :gray },
          badge_count: 40
        }
      )
    end
  end
end
