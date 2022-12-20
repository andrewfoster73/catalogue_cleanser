# frozen_string_literal: true

require 'test_helper'

class TasksCompletedByDayTest < ActiveSupport::TestCase
  setup do
    travel_to('2022-12-01') do
      create(:task, :complete)
      create(:task, :pending)
      create(:task, :complete)
    end
    travel_to('2022-12-12') do
      create(:task, :complete)
    end
  end

  test 'returns count of completed tasks grouped by day' do
    results = Queries::TasksCompletedByDay.to_h
    assert_includes(results.to_a, ['2022-12-01', 2])
    assert_includes(results.to_a, ['2022-12-12', 1])
  end
end
