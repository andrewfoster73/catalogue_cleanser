# frozen_string_literal: true

require 'test_helper'

class TransactionUsageQuartilesTest < ActiveSupport::TestCase
  test 'returns values for low (25%), medium (50%) and high (75%)' do
    quartiles = Queries::TransactionUsageQuartiles.call
    assert_equal(91.5, quartiles.low)
    assert_equal(111.0, quartiles.medium)
    assert_equal(130.5, quartiles.high)
  end
end
