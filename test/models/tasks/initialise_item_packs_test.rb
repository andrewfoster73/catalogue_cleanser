# frozen_string_literal: true

require 'test_helper'

class Tasks::InitialiseItemPacksTest < ActiveSupport::TestCase
  setup do
    @task = Tasks::InitialiseItemPacks.create!
    ItemPack.includes(:item_pack_aliases).destroy_all
  end

  test 'creates item packs' do
    assert_equal('pending', @task.status, 'Task initial status is not pending')
    @task.call
    assert_equal(73, ItemPack.count, 'Number of ItemPacks created is not 73')
    assert_equal('complete', @task.status, 'Task final status is not complete')
  end
end
