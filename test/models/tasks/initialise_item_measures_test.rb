# frozen_string_literal: true

require 'test_helper'

class Tasks::InitialiseItemMeasuresTest < ActiveSupport::TestCase
  setup do
    @task = Tasks::InitialiseItemMeasures.create!
  end

  test 'creates item measures' do
    assert_equal('pending', @task.status, 'Task initial status is not pending')
    @task.call
    assert_equal(105, ItemMeasure.count, 'Number of ItemMeasures created is not 105')
    assert_equal('complete', @task.status, 'Task final status is not complete')
  end
end
