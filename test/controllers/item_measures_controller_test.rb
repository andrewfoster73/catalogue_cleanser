# frozen_string_literal: true

require 'test_helper'

class ItemMeasuresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item_measure = item_measures(:one)
  end

  test 'should redirect if not authenticated' do
    get item_measures_url
    assert_redirected_to :root
  end

  test 'should get index' do
    authenticate
    get item_measures_url
    assert_response :success
  end

  test 'should get new' do
    authenticate
    get new_item_measure_url
    assert_response :success
  end

  test 'should create item_measure' do
    authenticate
    assert_difference('ItemMeasure.count') do
      post item_measures_url,
           params: { item_measure: { canonical: @item_measure.canonical, name: "a #{@item_measure.name}" } }
    end

    assert_redirected_to item_measure_url(ItemMeasure.last, format: :html)
  end

  test 'should show item_measure' do
    authenticate
    get item_measure_url(@item_measure)
    assert_response :success
  end

  test 'should get edit' do
    authenticate
    get edit_item_measure_url(@item_measure)
    assert_response :success
  end

  test 'should update item_measure' do
    authenticate
    patch item_measure_url(@item_measure),
          params: { item_measure: { canonical: @item_measure.canonical, name: @item_measure.name } }
    assert_redirected_to item_measure_url(@item_measure)
  end

  test 'should destroy item_measure' do
    authenticate
    assert_difference('ItemMeasure.count', -1) do
      delete item_measure_url(@item_measure)
    end

    assert_redirected_to item_measures_url
  end
end
