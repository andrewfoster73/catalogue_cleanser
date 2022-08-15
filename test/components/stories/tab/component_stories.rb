# frozen_string_literal: true

module Tab
  class ComponentStories < ApplicationStories
    story :active_with_badge do
      constructor(id: 'tab', label: text('Audit'), url: '#audit', active: true, options: {
        icon_options: { name: :folder_open, colour: :gray },
        badge_count: 5
      }
      )
    end

    story :inactive_with_badge do
      constructor(id: 'tab', label: text('Audit'), url: '#audit', active: false, options: {
        icon_options: { name: :folder_open, colour: :gray },
        badge_count: 21
      }
      )
    end

    story :active_without_badge do
      constructor(id: 'tab', label: text('Audit'), url: '#audit', active: true, options: {
        icon_options: { name: :folder_open, colour: :gray }
      }
      )
    end

    story :inactive_without_badge do
      constructor(id: 'tab', label: text('Audit'), url: '#audit', active: false, options: {
        icon_options: { name: :folder_open, colour: :gray }
      }
      )
    end

    story :active_without_icon do
      constructor(id: 'tab', label: text('Audit'), url: '#audit', active: true)
    end

    story :inactive_without_icon do
      constructor(id: 'tab', label: text('Audit'), url: '#audit', active: false)
    end
  end
end
