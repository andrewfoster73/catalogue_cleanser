# frozen_string_literal: true

require 'test_helper'

class ItemMeasureAliasTest < ActiveSupport::TestCase
  test 'alias presence validation' do
    item_measure_alias = build(:item_measure_alias, alias: nil, confirmed: nil)
    assert_not(item_measure_alias.save, 'Saved the item measure alias without required attributes')
  end

  test 'alias uniqueness validation' do
    # NOTE: there is an ItemMeasureAlias with a name of 'one alias' already in the fixtures
    item_measure_alias = build(:item_measure_alias, alias: 'one alias', confirmed: nil)
    assert_not(item_measure_alias.save, 'Saved the item measure alias using a duplicate name')
  end

  test 'cleaning' do
    item_measure_alias = build(:item_measure_alias, alias: " 5  Btl  \n")
    item_measure_alias.valid?
    assert_equal('btl', item_measure_alias.alias, 'Item measure alias contains illegal whitespace')
  end
end
