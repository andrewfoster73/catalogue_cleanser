# frozen_string_literal: true

require 'test_helper'

class CatalogueUsageQuartilesTest < ActiveSupport::TestCase
  test 'returns values for low (25%), medium (50%) and high (75%)' do
    quartiles = Queries::CatalogueUsageQuartiles.call
    assert_equal(17.0, quartiles.low)
    assert_equal(27.0, quartiles.medium)
    assert_equal(30.0, quartiles.high)
  end
end
