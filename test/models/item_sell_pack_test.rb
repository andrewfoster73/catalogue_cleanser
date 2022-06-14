# frozen_string_literal: true

require 'test_helper'

class ItemSellPackTest < ActiveSupport::TestCase
  test 'name presence validation' do
    item_sell_pack = build(:item_sell_pack, name: nil, canonical: nil)
    assert_not(item_sell_pack.save, 'Saved the item sell pack without required attributes')
  end

  test 'name uniqueness validation' do
    # NOTE: there is an ItemSellPack with a name of 'carton' already in the fixtures
    item_sell_pack = build(:item_sell_pack, name: 'carton', canonical: nil)
    assert_not(item_sell_pack.save, 'Saved the item sell pack using a duplicate name')
  end

  test 'cleaning' do
    item_sell_pack = build(:item_sell_pack, name: " 5  Btl  \n")
    item_sell_pack.valid?
    assert_equal('btl', item_sell_pack.name, 'Item sell pack contains illegal whitespace')
  end
end
