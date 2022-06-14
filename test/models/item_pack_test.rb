# frozen_string_literal: true

require 'test_helper'

class ItemPackTest < ActiveSupport::TestCase
  test 'name presence validation' do
    item_pack = build(:item_pack, name: nil, canonical: nil)
    assert_not(item_pack.save, 'Saved the item pack without required attributes')
  end

  test 'name uniqueness validation' do
    # NOTE: there is an ItemPack with a name of 'carton' already in the fixtures
    item_pack = build(:item_pack, name: 'carton', canonical: nil)
    assert_not(item_pack.save, 'Saved the item pack using a duplicate name')
  end

  test 'cleaning' do
    item_pack = build(:item_pack, name: " 5  Btl  \n")
    item_pack.valid?
    assert_equal('btl', item_pack.name, 'Item pack contains illegal whitespace')
  end
end
