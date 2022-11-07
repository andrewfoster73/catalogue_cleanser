# frozen_string_literal: true

require 'test_helper'

class BrandTest < ActiveSupport::TestCase
  test 'name presence validation' do
    brand = build(:brand, name: nil, canonical: nil)
    assert_not(brand.save, 'Saved the brand without required attributes')
  end

  test 'name uniqueness validation' do
    # NOTE: there is a Brand with a name of 'Heinz' already in the fixtures
    brand = build(:brand, name: 'Heinz', canonical: nil)
    assert_not(brand.save, 'Saved the brand using a duplicate name')
  end

  test 'count validation' do
    brand = build(:brand, name: 'Apple (U.K.)', count: -1)
    assert_not(brand.save, 'Saved the brand using a negative count')
  end

  test 'cleaning' do
    brand = build(:brand, name: " Apple (U.S.A.)  \n")
    brand.valid?
    assert_equal('Apple (U.S.A.)', brand.name, 'Brand contains illegal whitespace')
  end

  test 'trademark check url' do
    brand = build(:brand, name: 'S.P.C.')
    assert_equal(
      'https://search.ipaustralia.gov.au/trademarks/search/quick/result?q=S.P.C.',
      brand.trademark_check_url
    )
    brand = build(:brand, name: 'Innis & Gunn')
    assert_equal(
      'https://search.ipaustralia.gov.au/trademarks/search/quick/result?q=Innis+%26+Gunn',
      brand.trademark_check_url
    )
  end

  test 'to_s' do
    brand = build(:brand, name: 'Microsoft')
    assert_equal('Microsoft', brand.to_s, 'Brand to string should be the name')
  end
end
