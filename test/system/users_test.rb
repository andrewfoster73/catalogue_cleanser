# frozen_string_literal: true

require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:saul)
  end

  test 'redirects if not logged in' do
    visit user_url(@user)
    assert_current_path(root_url)
  end

  test 'should update User' do
    login
    visit user_url(@user)
    click_on 'Edit', exact: true

    find("#user_#{@user.id}_locale--button").click
    find("#user_#{@user.id}_locale--th-value").click
    click_on 'Update'

    assert_selector("#user_#{@user.id}_locale--hidden-input[value=\"th\"]", visible: false)
    assert_text "User '#{@user}' was successfully updated"
  end

  test 'show page tabs' do
    login
    visit user_url(@user)
    assert_selector("a#tab_user_#{@user.id}_details", text: 'Details')
    assert_selector("a#tab_user_#{@user.id}_audit", text: 'Audit')

    click_on 'Details'
    assert_current_path(user_url(@user))
    click_on 'Audit'
    assert_current_path(user_audits_url(user_id: @user))
  end

  test 'edit page tabs' do
    login
    visit edit_user_url(@user)
    assert_selector("a#tab_user_#{@user.id}_details", text: 'Details')
    assert_selector("a#tab_user_#{@user.id}_audit", text: 'Audit')

    click_on 'Details'
    assert_current_path(edit_user_url(@user))
    click_on 'Audit'
    assert_current_path(user_audits_url(user_id: @user))
  end

  test 'updating record should update audits badge count' do
    badge_count = @user.audits.size
    login
    visit edit_user_url(@user)
    assert_selector(
      "#tab_user_#{@user.id}_audit--badge_count__integer",
      text: badge_count
    )

    find("#user_#{@user.id}_locale--button").click
    find("#user_#{@user.id}_locale--th-value").click
    click_on 'Update'

    assert_selector(
      "#tab_user_#{@user.id}_audit--badge_count__integer",
      text: badge_count + 1
    )
  end
end
