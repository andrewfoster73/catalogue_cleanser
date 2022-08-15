# frozen_string_literal: true

require 'test_helper'

class ItemSellPacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item_sell_pack = item_sell_packs(:carton)
  end

  test 'should redirect if not authenticated' do
    get item_sell_packs_url
    assert_redirected_to :root
  end

  test 'should get index' do
    authenticate
    get item_sell_packs_url
    assert_response :success
  end

  test 'should create item_sell_pack' do
    authenticate
    assert_difference('ItemSellPack.count') do
      post item_sell_packs_url,
           params: { item_sell_pack: { canonical: @item_sell_pack.canonical, name: "a #{@item_sell_pack.name}" } }
    end

    assert_redirected_to item_sell_pack_url(ItemSellPack.last, format: :html)
  end

  test 'should show item_sell_pack' do
    authenticate
    get item_sell_pack_url(@item_sell_pack)
    assert_response :success
  end

  test 'should get edit' do
    authenticate
    get edit_item_sell_pack_url(@item_sell_pack)
    assert_response :success
  end

  test 'should update item_sell_pack' do
    authenticate
    patch item_sell_pack_url(@item_sell_pack),
          params: { item_sell_pack: { canonical: @item_sell_pack.canonical, name: @item_sell_pack.name } }
    assert_redirected_to item_sell_pack_url(@item_sell_pack, format: :html)
  end

  test 'should destroy item_sell_pack' do
    authenticate
    assert_difference('ItemSellPack.count', -1) do
      delete item_sell_pack_url(@item_sell_pack)
    end

    assert_redirected_to item_sell_packs_url
  end

  test 'redirect when record not found' do
    authenticate
    get item_sell_pack_url(0)

    assert_redirected_to item_sell_packs_url
    assert_equal('Item sell pack could not be found.', flash[:error])
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
      @item_sell_pack.stub(:update, -> { raise(StandardError) }) do
        authenticate

        get edit_item_sell_pack_url(@item_sell_pack, format: :json)
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
    ItemSellPack.stub(:find, -> (_id) { raise(StandardError) }) do
      authenticate

      assert_raises(StandardError) do
        get item_sell_pack_url(@item_sell_pack, format: :turbo_stream)
      end
    end
  end

  test 'raises error for HTML' do
    ItemSellPack.stub(:find, -> (_id) { raise(StandardError) }) do
      authenticate

      assert_raises(StandardError) do
        get item_sell_pack_url(@item_sell_pack)
      end
    end
  end
end
