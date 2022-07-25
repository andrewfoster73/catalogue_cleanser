# frozen_string_literal: true

require 'test_helper'

class BrandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @brand = brands(:one)
  end

  test 'should redirect if not authenticated' do
    get brands_url
    assert_redirected_to :root
  end

  test 'should get index' do
    authenticate
    get brands_url
    assert_response :success
  end

  test 'should get new' do
    authenticate
    get new_brand_url
    assert_response :success
  end

  test 'should create brand' do
    authenticate
    assert_difference('Brand.count') do
      post brands_url, params: { brand: { canonical: @brand.canonical, count: @brand.count, name: "a #{@brand.name}" } }
    end

    assert_redirected_to brand_url(Brand.last, format: :html)
  end

  test 'should show brand' do
    authenticate
    get brand_url(@brand)
    assert_response :success
  end

  test 'should get edit' do
    authenticate
    get edit_brand_url(@brand)
    assert_response :success
  end

  test 'should update brand' do
    authenticate
    patch brand_url(@brand), params: { brand: { canonical: @brand.canonical, count: @brand.count, name: @brand.name } }
    assert_redirected_to brand_url(@brand)
  end

  test 'should destroy brand' do
    authenticate
    assert_difference('Brand.count', -1) do
      delete brand_url(@brand)
    end

    assert_redirected_to brands_url
  end
end
