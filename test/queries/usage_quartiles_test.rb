# frozen_string_literal: true

require 'test_helper'

class UsageQuartilesTest < ActiveSupport::TestCase
  setup do
    @product = products(:lager)
  end

  test 'returns values for low (25%), medium (50%) and high (75%) for catalogue attributes' do
    quartiles = Queries::UsageQuartiles.call(
      scope: Product.all, options: { attributes: @product.catalogue_usage_attributes }
    )
    assert_equal(17.0, quartiles.low)
    assert_equal(27.0, quartiles.medium)
    assert_equal(30.0, quartiles.high)
  end

  test 'returns values for low (25%), medium (50%) and high (75%) for transaction attributes' do
    quartiles = Queries::UsageQuartiles.call(
      scope: Product.all, options: { attributes: @product.transaction_usage_attributes }
    )
    assert_equal(97.5, quartiles.low)
    assert_equal(123.0, quartiles.medium)
    assert_equal(148.5, quartiles.high)
  end

  test 'returns values for low (25%), medium (50%) and high (75%) for settings attributes' do
    quartiles = Queries::UsageQuartiles.call(
      scope: Product.all, options: { attributes: @product.settings_usage_attributes }
    )
    assert_equal(17.0, quartiles.low)
    assert_equal(23.0, quartiles.medium)
    assert_equal(32.0, quartiles.high)
  end
end
