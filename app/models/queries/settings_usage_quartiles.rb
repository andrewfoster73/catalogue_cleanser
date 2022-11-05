# frozen_string_literal: true

module Queries
  class SettingsUsageQuartiles < Base
    def initialize(scope: nil)
      super(scope: scope || Product.all)
    end

    def call(*)
      @scope
        .select(
          "PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY #{sum_of_settings}) AS low," \
          "PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY #{sum_of_settings}) AS medium," \
          "PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY #{sum_of_settings}) AS high"
        )
        .find_by(
          "(#{sum_of_settings}) > 0"
        )
    end

    def sum_of_settings
      'inventory_barcodes_count + procurement_products_count + product_supplier_preferences_count + ' \
      'rebates_profile_products_count'
    end
  end
end
