# frozen_string_literal: true

require 'test_helper'

class ItemPackAliasTest < ActiveSupport::TestCase
  test 'alias presence validation' do
    item_pack_alias = build(:item_pack_alias, alias: nil, confirmed: nil)
    assert_not(item_pack_alias.save, 'Saved the item pack alias without required attributes')
  end

  test 'alias uniqueness validation' do
    # NOTE: there is an ItemPackAlias with a name of 'one alias' already in the fixtures
    item_pack_alias = build(:item_pack_alias, alias: 'one alias', confirmed: nil)
    assert_not(item_pack_alias.save, 'Saved the item pack alias using a duplicate name')
  end

  test 'cleaning' do
    item_pack_alias = build(:item_pack_alias, alias: " 5  Btl  \n")
    item_pack_alias.valid?
    assert_equal('btl', item_pack_alias.alias, 'Item pack alias contains illegal whitespace')
  end
end
