# frozen_string_literal: true

module CollectionFilter
  class ListComponent < ViewComponent::Base
    # @return [String] the label for the filter
    attr_reader :label
    # @return [Symbol] the name of the attribute to filter on
    attr_reader :attribute
    # @return [Array<Hash>] the display and value for 1 or more list options
    attr_reader :options
    # @return [Boolean] true if the options component is hidden, false otherwise
    attr_reader :hidden

    def initialize(label:, attribute:, options: [], hidden: true)
      super
      @label = label
      @attribute = attribute
      @options = options
      @hidden = hidden
    end

    private

    def option_checked(value:)
      selected_options.include?(value)
    end

    # @todo Inject the parameters instead?
    def selected_options
      params.dig(:q, "#{attribute}_in") || []
    end
  end
end
