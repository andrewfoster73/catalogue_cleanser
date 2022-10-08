# frozen_string_literal: true

module ResourceForm
  class NumberComponent < BaseComponent
    # @return [Number] the minimum acceptable value for the input
    attr_reader :min
    # @return [Number] the maximum acceptable value for the input
    attr_reader :max
    # @return [Number] the number of allowed decimal places (also affects the spinbutton increments)
    attr_reader :step

    # @param [String] attribute model attribute to either display or provide an input for
    # @param [String] label a label for the field, must have i18n already applied
    # @param [ActiveRecord] resource an instance of an ActiveRecord object to read data from
    # @param [Hash] options additional configuration options for the field
    # @option options [String] :help a message to place near the label to help the user understand the attribute
    # @option options [Boolean] :readonly is this attribute currently editable?
    # @option options [Boolean] :editable is this attribute ever editable?
    # @option options [Boolean] :required is this attribute required to have a value?
    # @option options [String] :invalid_message if this field is invalid what message to display
    # @option options [Number] :min the minimum acceptable value for the input
    # @option options [Number] :max the maximum acceptable value for the input
    # @option options [Number] :step the number of allowed decimal places (also affects the spinbutton increments)
    # @example Number with a minimum value of 0 and allowing up to 4 decimal places
    #   ResourceForm::NumberComponent.new(
    #     attribute: :item_sell_quantity,
    #     label: resource_class.human_attribute_name(:item_sell_quantity),
    #     resource: resource,
    #     options: {
    #       readonly: readonly,
    #       required: true, min: 0.0, step: 0.0001,
    #       invalid_message: t('.invalid_message.item_sell_quantity')
    #     }
    #   )
    def initialize(attribute:, label:, resource:, options: nil)
      super
      @min = options[:min]
      @max = options[:max]
      @step = options[:step]
    end

    private

    def data_actions
      %w[
        keydown->editor#save
        keydown->editor#cancel
        focus->resource-form--component#selectAll
        keydown->resource-form--component#change
      ]
    end
  end
end
