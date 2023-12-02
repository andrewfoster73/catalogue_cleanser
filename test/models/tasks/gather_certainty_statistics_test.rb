# frozen_string_literal: true

require 'test_helper'

class Tasks::GatherCertaintyStatisticsTest < ActiveSupport::TestCase
  setup do
    @product = products(:lager)
    @task = Tasks::GatherCertaintyStatistics.create!
  end

  test 'updates counts on products' do
    assert_equal('pending', @task.status, 'Task initial status is not pending')
    assert_changes(-> { @product.reload.collected_certainty_at }) do
      @task.call
    end
    assert_equal('complete', @task.reload.status)
    @product.reload
    assert_equal(0, @product.duplication_certainty)
    assert_equal(1, @product.canonical_certainty)
  end
end
