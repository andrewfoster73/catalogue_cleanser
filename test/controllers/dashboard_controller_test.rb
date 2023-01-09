# frozen_string_literal: true

require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  setup do
    authenticate
  end

  test 'GET percentage_products_with_issues_vs_none' do
    get dashboard_percentage_products_with_issues_vs_none_url(format: :json)
    assert_response :success
    parsed_response = JSON.parse(@response.body)
    assert_equal({ 'No Issues' => 66.67, 'Issues' => 33.33 }, parsed_response)
  end

  test 'GET percentage_products_used_vs_not_used' do
    get dashboard_percentage_products_used_vs_not_used_url(format: :json)
    assert_response :success
    parsed_response = JSON.parse(@response.body)
    assert_equal({ 'Used' => 100.0, 'Not Used' => 0.0 }, parsed_response)
  end

  test 'GET products_created_by_month' do
    get dashboard_products_created_by_month_url(format: :json)
    assert_response :success
    parsed_response = JSON.parse(@response.body)
    assert_equal({}, parsed_response)
  end

  test 'GET product_issues_by_type' do
    get dashboard_product_issues_by_type_url(format: :json)
    assert_response :success
    parsed_response = JSON.parse(@response.body)
    assert_includes(parsed_response.find { |r| r['name'] == 'fixed' }['data'], ['Extraneous Whitespace', 1])
    assert_includes(parsed_response.find { |r| r['name'] == 'confirmed' }['data'], ['Missing Compulsory Attribute', 1])
    assert_includes(parsed_response.find { |r| r['name'] == 'confirmed' }['data'], ['Invalid Locale', 1])
  end

  test 'GET tasks_completed_by_day' do
    get dashboard_tasks_completed_by_day_url(format: :json)
    assert_response :success
    parsed_response = JSON.parse(@response.body)
    assert_equal({}, parsed_response)
  end
end
