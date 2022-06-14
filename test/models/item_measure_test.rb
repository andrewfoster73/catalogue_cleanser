# frozen_string_literal: true

require 'test_helper'

class ItemMeasureTest < ActiveSupport::TestCase
  test 'name presence validation' do
    item_measure = build(:item_measure, name: nil, canonical: nil)
    assert_not(item_measure.save, 'Saved the item measure without required attributes')
  end

  test 'name uniqueness validation' do
    # NOTE: there is an ItemMeasure with a name of 'ml' already in the fixtures
    item_measure = build(:item_measure, name: 'ml', canonical: nil)
    assert_not(item_measure.save, 'Saved the item measure using a duplicate name')
  end

  test 'cleaning' do
    item_measure = build(:item_measure, name: " 5  Btl  \n")
    item_measure.valid?
    assert_equal('btl', item_measure.name, 'Item measure contains illegal whitespace')
  end
end
