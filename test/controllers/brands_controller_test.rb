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
    assert_redirected_to brand_url(@brand, format: :html)
  end

  test 'should destroy brand' do
    authenticate
    assert_difference('Brand.count', -1) do
      delete brand_url(@brand)
    end

    assert_redirected_to brands_url
  end

  test 'redirect when record not found' do
    authenticate
    get brand_url(0)

    assert_redirected_to brands_url
    assert_equal('Brand could not be found.', flash[:error])
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
      @brand.stub(:update, -> { raise(StandardError) }) do
        authenticate

        get edit_brand_url(@brand, format: :json)
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
    Brand.stub(:find, -> (_id) { raise(StandardError) }) do
      authenticate

      assert_raises(StandardError) do
        get brand_url(@brand, format: :turbo_stream)
      end
    end
  end

  test 'raises error for HTML' do
    Brand.stub(:preload, -> (_) { raise(StandardError) }) do
      authenticate

      assert_raises(StandardError) do
        get brand_url(@brand)
      end
    end
  end
end
