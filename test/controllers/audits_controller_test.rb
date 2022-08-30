# frozen_string_literal: true

require 'test_helper'

class AuditsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item_sell_pack = create(:item_sell_pack, name: 'container')
    @audit = @item_sell_pack.audits.first
  end

  test 'should redirect if not authenticated' do
    get item_sell_pack_audits_url(item_sell_pack_id: @item_sell_pack)
    assert_redirected_to :root
  end

  test 'should get index when nested' do
    authenticate
    get item_sell_pack_audits_url(item_sell_pack_id: @item_sell_pack)
    assert_response :success
  end

  test 'should not be able to get new' do
    authenticate
    assert_raises(ActionController::RoutingError) do
      get '/audits/new'
    end
  end

  test 'should not create audit' do
    authenticate
    assert_raises(ActionController::RoutingError) do
      post '/audits', params: { audit: {} }
    end
  end

  test 'should not show audit' do
    authenticate
    assert_raises(ActionController::RoutingError) do
      get '/audits/5'
    end
  end

  test 'should not get edit' do
    authenticate
    assert_raises(ActionController::RoutingError) do
      get '/audits/4/edit'
    end
  end

  test 'should not update audit' do
    authenticate
    assert_raises(ActionController::RoutingError) do
      patch '/audits/5', params: { audit: {} }
    end
  end

  test 'should not destroy audit' do
    authenticate
    assert_raises(ActionController::RoutingError) do
      delete '/audits/5'
    end
  end
end
