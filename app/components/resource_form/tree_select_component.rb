# frozen_string_literal: true

module ResourceForm
  class TreeSelectComponent < BaseComponent
    # @return [Array] the roots of the tree
    attr_reader :roots
    # @return [Class] the class that implements a roots method
    attr_reader :root_class
    # @return [String] the currently selected value
    attr_reader :selected_value
    # @return [Boolean] true if the items list is hidden, false otherwise
    attr_reader :hidden

    def initialize(attribute:, label:, resource:, root_class:, hidden: true, options: {})
      super(attribute: attribute, label: label, resource: resource, options: options)
      @root_class = root_class
      @roots = root_class.roots
      @selected_value = resource.send(attribute)
      @hidden = hidden
    end

    private

    def selected?(value:)
      selected_value == value
    end

    def selected_text
      selected_item&.to_s
    end

    def selected_item
      root_class.find_by(id: selected_value)
    end
  end
end
