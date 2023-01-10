# frozen_string_literal: true

module ProductPricing
  class ComponentStories < ApplicationStories
    story :basic do
      constructor(
        resource: klazz(
          Product,
          collected_pricing_at: Time.zone.now,
          price_country: 'AU',
          price_count: 10,
          average_price: 5.5,
          median_price: 7.2,
          minimum_price: 3.9,
          maximum_price: 9.89,
          standard_deviation: 1.23
        )
      )
    end
  end
end
