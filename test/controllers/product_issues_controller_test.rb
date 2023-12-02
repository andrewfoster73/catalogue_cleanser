# frozen_string_literal: true

require 'test_helper'

class ProductIssuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_issue = product_issues(:missing_compulsory)
  end

  test 'should redirect if not authenticated' do
    get product_issues_url
    assert_redirected_to :root
  end

  test 'should get index' do
    authenticate
    get product_issues_url
    assert_response :success
  end

  test 'should update product_issue' do
    authenticate
    patch product_issue_url(@product_issue),
          params: {
            product_issue: {
              status: :pending
            }
          }
    assert_redirected_to product_issues_url(format: :html)
  end

  test 'should destroy product_issue' do
    authenticate
    assert_difference('ProductIssue.count', -1) do
      delete product_issue_url(@product_issue)
    end

    assert_redirected_to product_issues_url
  end
end
