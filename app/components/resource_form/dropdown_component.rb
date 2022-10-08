# frozen_string_literal: true

module ResourceForm
  class DropdownComponent < BaseComponent
    # @return [Array<Hash>] the items to display in the dropdown
    attr_reader :items
    # @return [String] the currently selected value
    attr_reader :selected_value
    # @return [Boolean] true if the items list is hidden, false otherwise
    attr_reader :hidden

    # @param [String] attribute model attribute to either display or provide an input for
    # @param [String] label a label for the field, must have i18n already applied
    # @param [ActiveRecord] resource an instance of an ActiveRecord object to read data from
    # @param [Array<Hash>] items the selectable elements to display in the dropdown.
    #   The hash should contain `text`, `value` and optionally a `css` class list
    #   Example:  `{ text: 'English (GB)', value: 'en-GB', css: 'fi fi-gb' }`
    # @param [Hash] options additional configuration options for the field
    # @option options [String] :help a message to place near the label to help the user understand the attribute
    # @option options [Boolean] :readonly is this attribute currently editable?
    # @option options [Boolean] :editable is this attribute ever editable?
    # @option options [Boolean] :required is this attribute required to have a value?
    # @option options [String] :invalid_message if this field is invalid what message to display
    # @example Number with a minimum value of 0 and allowing up to 4 decimal places
    #   ResourceForm::DropdownComponent.new(
    #     attribute: :item_sell_pack_name,
    #     label: resource_class.human_attribute_name(:item_sell_pack_name),
    #     resource: resource,
    #     items: ItemSellPack.canonical.order(:name).map { |pack| { text: pack.name, value: pack.name } },
    #     options: { readonly: readonly, required: true, invalid_message: t('.invalid_message.item_sell_pack_name') }
    #   )
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
