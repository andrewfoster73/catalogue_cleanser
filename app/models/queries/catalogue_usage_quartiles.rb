# frozen_string_literal: true

module Queries
  class CatalogueUsageQuartiles < Base
    def initialize(scope: nil)
      super(scope: scope || Product.all)
    end

    def call(*)
      @scope
        .select(
          "PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY #{sum_of_catalogues}) AS low," \
          "PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY #{sum_of_catalogues}) AS medium," \
          "PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY #{sum_of_catalogues}) AS high"
        )
        .find_by(
          "(#{sum_of_catalogues}) > 0"
        )
    end

    def sum_of_catalogues
      'catalogue_count + recipes_count + inventory_stock_levels_count + inventory_derived_period_balances_count'
    end
  end
end
