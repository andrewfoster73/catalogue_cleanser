# frozen_string_literal: true

module EditableCell
  class Component < ViewComponent::Base
    attr_reader :url, :resource, :attribute, :formatter

    def initialize(url:, resource:, attribute:, formatter: :string)
      super
      @url = url
      @resource = resource
      @attribute = attribute
      @formatter = formatter
    end

    def display
      public_send("#{@formatter}_formatter")
    end

    def string_formatter
      resource.public_send(@attribute)
    end
  end
end
