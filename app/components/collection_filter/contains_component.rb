# frozen_string_literal: true

module CollectionFilter
  # A text filter that uses the Ransack _cont predicate to search the given attribute
  class ContainsComponent < ViewComponent::Base
    # @return [String] the label for the filter
    attr_reader :label
    # @return [Symbol] the name of the attribute to filter on
    attr_reader :attribute

    def initialize(label:, attribute:)
      super
      @label = label
      @attribute = attribute
    end

    def input_value
      params.dig(:q, "#{attribute}_cont")
    end
  end
end
