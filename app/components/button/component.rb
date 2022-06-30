# frozen_string_literal: true

module Button
  class Component < ViewComponent::Base
    include IconsHelper

    attr_reader :id, :label, :options

    # options:
    # - title: Appears when hovering over the button
    # - colour_classes: TailwindCSS colour related classes to add
    # - icon: See IconsHelper
    # - data
    #   - action: Stimulus events e.g. 'click->editor#toggle'
    #   - params: Stimulus parameters e.g. { name: 'editor-id', value: 1 }

    def initialize(id:, label:, options: {})
      super
      @id = id
      @label = label
      @options = options
    end
  end
end
