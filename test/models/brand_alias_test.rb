# frozen_string_literal: true

require 'test_helper'

class BrandAliasTest < ActiveSupport::TestCase
  test 'alias presence validation' do
    brand_alias = build(:brand_alias, alias: nil, confirmed: nil)
    assert_not(brand_alias.save, 'Saved the brand alias without required attributes')
  end

  test 'alias uniqueness validation' do
    # NOTE: there is a BrandAlias with a name of 'one alias' already in the fixtures
    brand_alias = build(:brand_alias, alias: 'one alias', confirmed: nil)
    assert_not(brand_alias.save, 'Saved the brand alias using a duplicate name')
  end

  test 'count validation' do
    brand_alias = build(:brand_alias, alias: 'Apple UK', count: -1)
    assert_not(brand_alias.save, 'Saved the brand alias using a negative count')
  end

  test 'cleaning' do
    brand_alias = build(:brand_alias, alias: " APL  \n")
    brand_alias.valid?
    assert_equal('APL', brand_alias.alias, 'Brand alias contains illegal whitespace')
  end
end
