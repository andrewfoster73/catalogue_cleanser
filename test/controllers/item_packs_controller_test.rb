# frozen_string_literal: true

require 'test_helper'

class ItemPacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item_pack = item_packs(:carton)
  end

  test 'should redirect if not authenticated' do
    get item_packs_url
    assert_redirected_to :root
  end

  test 'should get index' do
    authenticate
    get item_packs_url
    assert_response :success
  end

  test 'should create item_pack' do
    authenticate
    assert_difference('ItemPack.count') do
      post item_packs_url, params: { item_pack: { canonical: @item_pack.canonical, name: "a #{@item_pack.name}" } }
    end

    assert_redirected_to item_pack_url(ItemPack.last, format: :html)
  end

  test 'should show item_pack' do
    authenticate
    get item_pack_url(@item_pack)
    assert_response :success
  end

  test 'should get edit' do
    authenticate
    get edit_item_pack_url(@item_pack)
    assert_response :success
  end

  test 'should update item_pack' do
    authenticate
    patch item_pack_url(@item_pack), params: { item_pack: { canonical: @item_pack.canonical, name: @item_pack.name } }
    assert_redirected_to item_pack_url(@item_pack, format: :html)
  end

  test 'should destroy item_pack' do
    authenticate
    assert_difference('ItemPack.count', -1) do
      delete item_pack_url(@item_pack)
    end

    assert_redirected_to item_packs_url
  end

  test 'redirect when record not found' do
    authenticate
    get item_pack_url(0)

    assert_redirected_to item_packs_url
    assert_equal('Item Pack could not be found.', flash[:error])
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
      @item_pack.stub(:update, -> { raise(StandardError) }) do
        authenticate

        get edit_item_pack_url(@item_pack, format: :json)
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
    ItemPack.stub(:find, -> (_id) { raise(StandardError) }) do
      authenticate

      assert_raises(StandardError) do
        get item_pack_url(@item_pack, format: :turbo_stream)
      end
    end
  end

  test 'raises error for HTML' do
    ItemPack.stub(:preload, -> (_) { raise(StandardError) }) do
      authenticate

      assert_raises(StandardError) do
        get item_pack_url(@item_pack)
      end
    end
  end
end
