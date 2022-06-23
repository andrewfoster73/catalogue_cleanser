# frozen_string_literal: true

module CollectionFilter
  class ToggleComponent < ViewComponent::Base
    attr_reader :form, :attribute

    def initialize(form:, attribute:)
      super
      @form = form
      @attribute = attribute
    end

    def true_field_name
      :"#{attribute}_true"
    end

    def not_true_field_name
      :"#{attribute}_not_true"
    end

    def toggle_id
      "filter_#{attribute}"
    end
  end
end
