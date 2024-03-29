# frozen_string_literal: true

require 'test_helper'

class ItemSellPackAliasTest < ActiveSupport::TestCase
  test 'alias presence validation' do
    item_sell_pack_alias = build(:item_sell_pack_alias, alias: nil, confirmed: nil)
    assert_not(item_sell_pack_alias.save, 'Saved the item sell pack alias without required attributes')
  end

  test 'alias uniqueness validation' do
    # NOTE: there is an ItemSellPackAlias with an alias of 'ctn' already in the fixtures
    item_sell_pack_alias = build(:item_sell_pack_alias, alias: 'ctn', confirmed: nil)
    assert_not(item_sell_pack_alias.save, 'Saved the item sell pack alias using a duplicate name')
  end

  test 'cleaning' do
    item_sell_pack_alias = build(:item_sell_pack_alias, alias: " 5  Btl  \n")
    item_sell_pack_alias.valid?
    assert_equal('btl', item_sell_pack_alias.alias, 'Item sell pack alias contains illegal whitespace')
  end

  test 'parent' do
    item_sell_pack = build(:item_sell_pack, name: 'carton')
    item_sell_pack_alias = build(:item_sell_pack_alias, item_sell_pack: item_sell_pack, alias: 'ctn')
    assert_equal(item_sell_pack, item_sell_pack_alias.parent)
  end

  test 'to_s' do
    item_sell_pack = build(:item_sell_pack, name: 'carton')
    item_sell_pack_alias = build(:item_sell_pack_alias, item_sell_pack: item_sell_pack, alias: 'ctn')
    assert_equal('ctn (carton)', item_sell_pack_alias.to_s)
  end
end
