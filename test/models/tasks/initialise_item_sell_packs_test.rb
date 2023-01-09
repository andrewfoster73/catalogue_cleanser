# frozen_string_literal: true

require 'test_helper'

class Tasks::InitialiseItemSellPacksTest < ActiveSupport::TestCase
  setup do
    @task = Tasks::InitialiseItemSellPacks.create!
    ItemSellPack.includes(:item_sell_pack_aliases).destroy_all
  end

  test 'creates item sell packs' do
    assert_equal('pending', @task.status, 'Task initial status is not pending')
    @task.call
    assert_equal(73, ItemSellPack.count, 'Number of ItemSellPacks created is not 73')
    assert_equal('complete', @task.status, 'Task final status is not complete')
  end
end
