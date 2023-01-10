# frozen_string_literal: true

module ProductPricing
  class Component < ViewComponent::Base
    attr_reader :resource

    def initialize(resource:)
      super
      @resource = resource
    end

    private

    def country_name
      ISO3166::Country.find_country_by_alpha2(@resource.price_country)&.iso_short_name
    end

    def currency_unit
      # TODO: Can add more logic here if necessary to support THB, GBP etc
      '$'
    end

    def coefficient_of_variation
      return 0 if @resource.average_price.nil? || @resource.average_price.zero?

      @resource.standard_deviation / @resource.average_price * 100
    end

    def confidence_interval
      return 0 if @resource.average_price.nil? || @resource.average_price.zero?
      return 0 if @resource.price_count.nil? || @resource.price_count.zero?

      1.96 * @resource.standard_deviation / Math.sqrt(@resource.price_count)
    end
  end
end
