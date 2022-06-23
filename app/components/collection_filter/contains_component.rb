# frozen_string_literal: true

module CollectionFilter
  class ContainsComponent < ViewComponent::Base
    attr_reader :form, :attribute

    def initialize(form:, attribute:)
      super
      @form = form
      @attribute = attribute
    end
  end
end
