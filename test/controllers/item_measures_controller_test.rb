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
    assert_redirected_to item_measure_url(@item_measure, format: :html)
  end

  test 'should destroy item_measure' do
    authenticate
    assert_difference('ItemMeasure.count', -1) do
      delete item_measure_url(@item_measure)
    end

    assert_redirected_to item_measures_url
  end

  test 'redirect when record not found' do
    authenticate
    get item_measure_url(0)

    assert_redirected_to item_measures_url
    assert_equal('Item Measure could not be found.', flash[:error])
  end

  test 'broadcast error for JSON' do
    mock = Minitest::Mock.new
    mock.expect(:call, nil) do |channel, partial:, locals:, target:|
      channel == 'errors' &&
        partial == 'notification' &&
        locals == {
          name: 'notification_error',
          type: 'error',
          message: 'We have encountered an error and cannot continue, contact us for help.'
        } &&
        target == 'notifications'
    end
    Turbo::StreamsChannel.stub(:broadcast_append_to, mock) do
      @item_measure.stub(:update, -> { raise(StandardError) }) do
        authenticate

        get edit_item_measure_url(@item_measure, format: :json)
        parsed_response = JSON.parse(@response.body)
        assert_equal(
          'We have encountered an error and cannot continue, contact us for help.',
          parsed_response['error'],
          'JSON error response was not correct'
        )
        assert_equal(500, @response.status, 'Request did not return status code 500')
      end
    end
  end

  test 'raises error for TURBO_STREAM' do
    ItemMeasure.stub(:find, -> (_id) { raise(StandardError) }) do
      authenticate

      assert_raises(StandardError) do
        get item_measure_url(@item_measure, format: :turbo_stream)
      end
    end
  end

  test 'raises error for HTML' do
    ItemMeasure.stub(:preload, -> (_) { raise(StandardError) }) do
      authenticate

      assert_raises(StandardError) do
        get item_measure_url(@item_measure)
      end
    end
  end
end
