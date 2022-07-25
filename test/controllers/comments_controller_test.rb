# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = comments(:one)
  end

  test 'should redirect if not authenticated' do
    get comments_url
    assert_redirected_to :root
  end

  test 'should get index' do
    authenticate
    get comments_url
    assert_response :success
  end

  test 'should get new' do
    authenticate
    get new_comment_url
    assert_response :success
  end

  test 'should create comment' do
    authenticate
    assert_difference('Comment.count') do
      post comments_url, params: { comment: { message: @comment.message } }
    end

    assert_redirected_to comment_url(Comment.last, format: :html)
  end

  test 'should show comment' do
    authenticate
    get comment_url(@comment)
    assert_response :success
  end

  test 'should get edit' do
    authenticate
    get edit_comment_url(@comment)
    assert_response :success
  end

  test 'should update comment' do
    authenticate
    patch comment_url(@comment), params: { comment: { message: @comment.message } }
    assert_redirected_to comment_url(@comment)
  end

  test 'should destroy comment' do
    authenticate
    assert_difference('Comment.count', -1) do
      delete comment_url(@comment)
    end

    assert_redirected_to comments_url
  end
end
