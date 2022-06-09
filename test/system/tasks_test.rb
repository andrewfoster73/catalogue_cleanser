# frozen_string_literal: true

require 'application_system_test_case'

class TasksTest < ApplicationSystemTestCase
  setup do
    @task = tasks(:one)
  end

  test 'visiting the index' do
    visit tasks_url
    assert_selector 'h1', text: 'Tasks'
  end

  test 'should create task' do
    visit tasks_url
    click_on 'New task'

    fill_in 'After', with: @task.after
    check 'Approved' if @task.approved
    fill_in 'Approved at', with: @task.approved_at
    fill_in 'Before', with: @task.before
    fill_in 'Context', with: @task.context_id
    fill_in 'Context type', with: @task.context_type
    fill_in 'Description', with: @task.description
    fill_in 'Error', with: @task.error
    check 'Requires approval' if @task.requires_approval
    fill_in 'Status', with: @task.status
    fill_in 'Type', with: @task.type
    click_on 'Create Task'

    assert_text 'Task was successfully created'
    click_on 'Back'
  end

  test 'should update Task' do
    visit task_url(@task)
    click_on 'Edit this task', match: :first

    fill_in 'After', with: @task.after
    check 'Approved' if @task.approved
    fill_in 'Approved at', with: @task.approved_at
    fill_in 'Before', with: @task.before
    fill_in 'Context', with: @task.context_id
    fill_in 'Context type', with: @task.context_type
    fill_in 'Description', with: @task.description
    fill_in 'Error', with: @task.error
    check 'Requires approval' if @task.requires_approval
    fill_in 'Status', with: @task.status
    fill_in 'Type', with: @task.type
    click_on 'Update Task'

    assert_text 'Task was successfully updated force error'
    click_on 'Back'
  end

  test 'should destroy Task' do
    visit task_url(@task)
    click_on 'Destroy this task', match: :first

    assert_text 'Task was successfully destroyed'
  end
end
