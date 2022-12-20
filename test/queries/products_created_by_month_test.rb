# frozen_string_literal: true

require 'test_helper'

class ProductsCreatedByMonthTest < ActiveSupport::TestCase
  setup do
    @master_catalogue = create(:external_catalogue)
    travel_to('2022-11-01') do
      create(:external_catalogued_product, external_product: products(:lager).external_product)
      create(:external_catalogued_product, external_product: products(:apple).external_product)
    end
    travel_to('2022-12-12') do
      create(:external_catalogued_product, external_product: products(:mince).external_product)
    end
  end

  test 'returns count of completed tasks grouped by day' do
    results = Queries::ProductsCreatedByMonth.to_h
    assert_includes(results.to_a, ['2022-11-01', 2])
    assert_includes(results.to_a, ['2022-12-01', 1])
  end
end
