# frozen_string_literal: true

require 'test_helper'

class ItemPackAliasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item_pack_alias = item_pack_aliases(:ctn)
  end

  test 'should redirect if not authenticated' do
    get item_pack_aliases_url
    assert_redirected_to :root
  end

  test 'should get index' do
    authenticate
    get item_pack_aliases_url
    assert_response :success
  end

  test 'should create item_pack_alias' do
    authenticate
    assert_difference('ItemPackAlias.count') do
      post item_pack_aliases_url,
           params: {
             item_pack_alias: {
               alias: "an #{@item_pack_alias.alias}",
               confirmed: @item_pack_alias.confirmed,
               item_pack_id: @item_pack_alias.item_pack_id
             }
           }
    end

    assert_redirected_to item_pack_alias_url(ItemPackAlias.last, format: :html)
  end

  test 'should show item_pack_alias' do
    authenticate
    get item_pack_alias_url(@item_pack_alias)
    assert_response :success
  end

  test 'should get edit' do
    authenticate
    get edit_item_pack_alias_url(@item_pack_alias)
    assert_response :success
  end

  test 'should update item_pack_alias' do
    authenticate
    patch item_pack_alias_url(@item_pack_alias),
          params: {
            item_pack_alias: {
              alias: @item_pack_alias.alias,
              confirmed: @item_pack_alias.confirmed,
              item_pack_id: @item_pack_alias.item_pack_id
            }
          }
    assert_redirected_to item_pack_alias_url(@item_pack_alias, format: :html)
  end

  test 'should destroy item_pack_alias' do
    authenticate
    assert_difference('ItemPackAlias.count', -1) do
      delete item_pack_alias_url(@item_pack_alias)
    end

    assert_redirected_to item_pack_aliases_url
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
      @item_pack_alias.stub(:update, -> { raise(StandardError) }) do
        authenticate

        get edit_item_pack_alias_url(@item_pack_alias, format: :json)
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
    ItemPackAlias.stub(:find, -> (_id) { raise(StandardError) }) do
      authenticate

      assert_raises(StandardError) do
        get item_pack_alias_url(@item_pack_alias, format: :turbo_stream)
      end
    end
  end

  test 'raises error for HTML' do
    ItemPackAlias.stub(:preload, -> (_id) { raise(StandardError) }) do
      authenticate

      assert_raises(StandardError) do
        get item_pack_alias_url(@item_pack_alias)
      end
    end
  end
end
