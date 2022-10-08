# frozen_string_literal: true

module ResourceForm
  class HiddenComponent < BaseComponent
    # @return [String] the initial value for the input
    attr_reader :value

    # @param [String] attribute model attribute to either display or provide an input for
    # @param [ActiveRecord] resource an instance of an ActiveRecord object to read data from
    # @param [Hash] options additional configuration options for the field
    # @option options [String] :help a message to place near the label to help the user understand the attribute
    # @option options [Boolean] :readonly is this attribute currently editable?
    # @option options [Boolean] :editable is this attribute ever editable?
    # @option options [Boolean] :required is this attribute required to have a value?
    # @option options [String] :invalid_message if this field is invalid what message to display
    # @option options [Number] :value the minimum acceptable value for the input
    # @example A hidden id field
    #   ResourceForm::HiddenComponent.new(
    #     attribute: :item_sell_pack_id,
    #     resource: resource,
    #     options: { value: @parent.id }
    #   )
    def initialize(attribute:, resource:, label: 'hidden', options: nil)
      super
      @value = options[:value]
    end
  end
end
