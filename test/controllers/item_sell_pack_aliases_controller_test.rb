# frozen_string_literal: true

require 'test_helper'

class ItemSellPackAliasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item_sell_pack_alias = item_sell_pack_aliases(:ctn)
  end

  test 'should redirect if not authenticated' do
    get item_sell_pack_aliases_url
    assert_redirected_to :root
  end

  test 'should get index' do
    authenticate
    get item_sell_pack_aliases_url
    assert_response :success
  end

  test 'should create item_sell_pack_alias' do
    authenticate
    assert_difference('ItemSellPackAlias.count') do
      post item_sell_pack_aliases_url,
           params: {
             item_sell_pack_alias: {
               alias: "an #{@item_sell_pack_alias.alias}",
               confirmed: @item_sell_pack_alias.confirmed,
               item_sell_pack_id: @item_sell_pack_alias.item_sell_pack_id
             }
           }
    end

    assert_redirected_to item_sell_pack_alias_url(ItemSellPackAlias.last, format: :html)
  end

  test 'should show item_sell_pack_alias' do
    authenticate
    get item_sell_pack_alias_url(@item_sell_pack_alias)
    assert_response :success
  end

  test 'should get edit' do
    authenticate
    get edit_item_sell_pack_alias_url(@item_sell_pack_alias)
    assert_response :success
  end

  test 'should update item_sell_pack_alias' do
    authenticate
    patch item_sell_pack_alias_url(@item_sell_pack_alias),
          params: {
            item_sell_pack_alias: {
              alias: @item_sell_pack_alias.alias,
              confirmed: @item_sell_pack_alias.confirmed,
              item_sell_pack_id: @item_sell_pack_alias.item_sell_pack_id
            }
          }
    assert_redirected_to item_sell_pack_alias_url(@item_sell_pack_alias, format: :html)
  end

  test 'should destroy item_sell_pack_alias' do
    authenticate
    assert_difference('ItemSellPackAlias.count', -1) do
      delete item_sell_pack_alias_url(@item_sell_pack_alias)
    end

    assert_redirected_to item_sell_pack_aliases_url
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
      @item_sell_pack_alias.stub(:update, -> { raise(StandardError) }) do
        authenticate

        get edit_item_sell_pack_alias_url(@item_sell_pack_alias, format: :json)
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
    ItemSellPackAlias.stub(:find, -> (_id) { raise(StandardError) }) do
      authenticate

      assert_raises(StandardError) do
        get item_sell_pack_alias_url(@item_sell_pack_alias, format: :turbo_stream)
      end
    end
  end

  test 'raises error for HTML' do
    ItemSellPackAlias.stub(:find, -> (_id) { raise(StandardError) }) do
      authenticate

      assert_raises(StandardError) do
        get item_sell_pack_alias_url(@item_sell_pack_alias)
      end
    end
  end
end
