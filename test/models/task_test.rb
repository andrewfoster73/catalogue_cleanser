# frozen_string_literal: true

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  setup do
    @task = Task.create!
  end

  test 'should raise an error and mark the task as failed' do
    assert_equal('pending', @task.status, 'Task initial status is not pending')
    assert_raises(NotImplementedError) do
      @task.call
    end
    assert_match(/NotImplementedError/, @task.error, 'Task error message should match NotImplementedError')
    assert_equal('error', @task.status, 'Task final status is not error')
  end

  test 'to_s' do
    assert_equal('This is a base task, it does nothing.', @task.to_s)
  end
end
