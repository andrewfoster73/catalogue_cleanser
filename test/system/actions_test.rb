# frozen_string_literal: true

require 'application_system_test_case'

class ActionsTest < ApplicationSystemTestCase
  setup do
    @action = actions(:one)
  end

  test 'visiting the index' do
    visit actions_url
    assert_selector 'h1', text: 'Actions'
  end

  test 'should create action' do
    visit actions_url
    click_on 'New action'

    fill_in 'After', with: @action.after
    check 'Approved' if @action.approved
    fill_in 'Approved at', with: @action.approved_at
    fill_in 'Approved by', with: @action.approved_by_id
    fill_in 'Before', with: @action.before
    fill_in 'Context', with: @action.context_id
    fill_in 'Context type', with: @action.context_type
    fill_in 'Description', with: @action.description
    fill_in 'Error', with: @action.error
    check 'Requires approval' if @action.requires_approval
    fill_in 'Status', with: @action.status
    fill_in 'Type', with: @action.type
    click_on 'Create Action'

    assert_text 'Action was successfully created'
    click_on 'Back'
  end

  test 'should update Action' do
    visit action_url(@action)
    click_on 'Edit this action', match: :first

    fill_in 'After', with: @action.after
    check 'Approved' if @action.approved
    fill_in 'Approved at', with: @action.approved_at
    fill_in 'Approved by', with: @action.approved_by_id
    fill_in 'Before', with: @action.before
    fill_in 'Context', with: @action.context_id
    fill_in 'Context type', with: @action.context_type
    fill_in 'Description', with: @action.description
    fill_in 'Error', with: @action.error
    check 'Requires approval' if @action.requires_approval
    fill_in 'Status', with: @action.status
    fill_in 'Type', with: @action.type
    click_on 'Update Action'

    assert_text 'Action was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Action' do
    visit action_url(@action)
    click_on 'Destroy this action', match: :first

    assert_text 'Action was successfully destroyed'
  end
end
