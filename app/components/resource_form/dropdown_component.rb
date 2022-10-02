# frozen_string_literal: true

module ResourceForm
  class DropdownComponent < BaseComponent
    attr_reader :items, :selected_value, :hidden

    def initialize(attribute:, label:, resource:, items:, hidden: true, options: {})
      super(attribute: attribute, label: label, resource: resource, options: options)
      @items = items
      @selected_value = resource.send(attribute)
      @hidden = hidden
    end

    private

    def selected?(value:)
      selected_value == value
    end

    def selected_text
      selected_item&.dig(:text)
    end

    def selected_item
      items.find { |o| o[:value] == selected_value }
    end
  end
end
