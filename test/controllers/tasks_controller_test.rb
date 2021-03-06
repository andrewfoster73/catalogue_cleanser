# frozen_string_literal: true

require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:one)
  end

  test 'should redirect if not authenticated' do
    get tasks_url
    assert_redirected_to :root
  end

  test 'should get index' do
    authenticate
    get tasks_url
    assert_response :success
  end

  test 'should get new' do
    authenticate
    get new_task_url
    assert_response :success
  end

  test 'should create task' do
    authenticate
    assert_difference('Task.count') do
      post tasks_url,
           params: {
             task: {
               after: @task.after,
               approved: @task.approved,
               approved_at: @task.approved_at,
               before: @task.before,
               context_id: @task.context_id,
               context_type: @task.context_type,
               description: @task.description,
               error: @task.error,
               requires_approval: @task.requires_approval,
               status: @task.status,
               type: @task.type
             }
           }
    end

    assert_redirected_to task_url(Task.last, format: :html)
  end

  test 'should show task' do
    authenticate
    get task_url(@task)
    assert_response :success
  end

  test 'should get edit' do
    authenticate
    get edit_task_url(@task)
    assert_response :success
  end

  test 'should update task' do
    authenticate
    patch task_url(@task),
          params: {
            task: {
              after: @task.after,
              approved: @task.approved,
              approved_at: @task.approved_at,
              before: @task.before,
              context_id: @task.context_id,
              context_type: @task.context_type,
              description: @task.description,
              error: @task.error,
              requires_approval: @task.requires_approval,
              status: @task.status,
              type: @task.type
            }
          }
    assert_redirected_to task_url(@task)
  end

  test 'should destroy task' do
    authenticate
    assert_difference('Task.count', -1) do
      delete task_url(@task)
    end

    assert_redirected_to tasks_url
  end
end
