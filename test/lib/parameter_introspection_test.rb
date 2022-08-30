# frozen_string_literal: true

require 'test_helper'

class ParameterIntrospectionTest < ActiveSupport::TestCase
  test 'can determine which parameter is an id' do
    instance = ParameterIntrospection.new(parameters: { 'item_sell_pack_id' => '176' })
    assert_equal('item_sell_pack_id', instance.id_param)
  end

  test 'returns first id parameter when there are multiple' do
    instance = ParameterIntrospection.new(
      parameters: { 'item_sell_pack_id' => '176', 'audit_id' => '88' }
    )
    assert_equal('item_sell_pack_id', instance.id_param)
  end

  test 'handles when other non-id parameters are present' do
    instance = ParameterIntrospection.new(
      parameters: { 'page' => '1', 'item_sell_pack_id' => '176' }
    )
    assert_equal('item_sell_pack_id', instance.id_param)
  end

  test 'returns class for id parameter' do
    instance = ParameterIntrospection.new(parameters: { 'item_sell_pack_id' => '176' })
    assert_equal(ItemSellPack, instance.id_param_class)
  end

  test 'returns instance of class for id parameter' do
    instance = ParameterIntrospection.new(parameters: { 'item_sell_pack_id' => item_sell_packs(:carton).id })
    assert_equal(item_sell_packs(:carton), instance.id_param_instance)
  end
end
