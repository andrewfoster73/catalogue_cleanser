# frozen_string_literal: true

module EditableCell
  class Component < ViewComponent::Base
    attr_reader :url, :resource, :attribute, :formatter, :error

    def initialize(url:, resource:, attribute:, formatter: :string, error: nil)
      super
      @url = url
      @resource = resource
      @attribute = attribute
      @formatter = formatter
      @error = error
    end

    private

    def display
      send("#{@formatter}_formatter")
    end

    def string_formatter
      resource.public_send(@attribute)
    end

    def text_formatter
      resource.public_send(@attribute)
    end

    def decimal_formatter
      number_with_precision(resource.public_send(@attribute), precision: 4, strip_insignificant_zeros: true)
    end
  end
end
