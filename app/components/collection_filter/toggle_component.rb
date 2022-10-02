# frozen_string_literal: true

module CollectionFilter
  # A toggle switch filter that uses the Ransack _not_true and true predicates to search the given attribute
  class ToggleComponent < ViewComponent::Base
    # @return [String] the label for the filter
    attr_reader :label
    # @return [Symbol] the name of the attribute to filter on
    attr_reader :attribute

    def initialize(label:, attribute:)
      super
      @label = label
      @attribute = attribute
    end

    private

    def true_field_name
      :"#{attribute}_true"
    end

    def true_field_value
      params.dig(:q, true_field_name) || '1'
    end

    def not_true_field_name
      :"#{attribute}_not_true"
    end

    def not_true_field_value
      params.dig(:q, not_true_field_name) || '0'
    end

    def toggle_id
      "filter_#{attribute}"
    end
  end
end
