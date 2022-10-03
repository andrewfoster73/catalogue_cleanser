# frozen_string_literal: true

module ResourceForm
  class DropdownComponent < BaseComponent
    # @return [Array<Hash>] the items to display in the dropdown
    attr_reader :items
    # @return [String] the currently selected value
    attr_reader :selected_value
    # @return [Boolean] true if the items list is hidden, false otherwise
    attr_reader :hidden

    # @param [Array<Hash>] items the selectable elements to display in the dropdown.
    #   The hash should contain `text`, `value` and optionally a `css` class list
    #   Example:  `{ text: 'English (GB)', value: 'en-GB', css: 'fi fi-gb' }`
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
