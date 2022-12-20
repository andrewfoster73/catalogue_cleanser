# frozen_string_literal: true

module Queries
  class ProductUsageCounts < Base
    module Scopes
      def having_product_id(product_id: nil)
        return all if product_id.nil?

        where(id: product_id)
      end

      def having_non_zero_count(coalesced_attributes:, only_non_zero: false)
        return all unless only_non_zero

        where("(#{coalesced_attributes.join(' + ')}) > 0")
      end
    end

    def initialize(scope:)
      super
      @scope = scope || Product.all
    end

    def call(options: {})
      @scope
        .extend(Scopes)
        .select("#{coalesced_attributes(attributes: options[:attributes]).join(' + ')} AS usage_count")
        .having_product_id(product_id: options[:product_id])
        .having_non_zero_count(
          coalesced_attributes: coalesced_attributes(attributes: options[:attributes]),
          only_non_zero: options[:only_non_zero]
        )
    end

    private

    def coalesced_attributes(attributes:)
      attributes.map do |a|
        "COALESCE(#{a}, 0)"
      end
    end

    def usage_attributes
      []
    end
  end
end
