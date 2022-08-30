# frozen_string_literal: true

module Breadcrumb
  class Component < ViewComponent::Base
    # @return [String] a unique identifier for setting the id on HTML elements in the component
    attr_reader :id
    # @return [String] the label to display on the breadcrumb
    attr_reader :label
    # @return [String] the URL to redirect to if the breadcrumb is clicked
    attr_reader :url
    # @return [Boolean] whether this breadcrumb should be styled as being active
    attr_reader :active

    def initialize(id:, label:, url:, active: false)
      super
      @id = id
      @label = label
      @url = url
      @active = active
    end

    private

    def active_classes
      active ? 'font-bold text-sky-500 hover:text-sky-700' : 'font-medium text-gray-500 hover:text-gray-700'
    end
  end
end
