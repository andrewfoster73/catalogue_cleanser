# frozen_string_literal: true

module Queries
  class ProductsCreatedByMonth < Base
    class << self
      def to_h(scope: nil, options: {})
        call(scope: scope, options: options).each_with_object({}) do |result, hash|
          hash[result.year_month] = result.count
        end
      end
    end

    def initialize(scope:)
      super
      @scope = scope || External::CataloguedProduct
    end

    def call(*)
      # Using a date greater than 2013-11-30 to skip all the initial imports
      @scope
        .managed
        .where("created_at > '2013-11-30'")
        .select("CONCAT(to_char(created_at, 'YYYY-MM'), '-01') AS year_month, COUNT(id) AS count")
        .group("to_char(created_at, 'YYYY-MM')")
    end
  end
end
