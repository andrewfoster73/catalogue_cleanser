# frozen_string_literal: true

require 'test_helper'

class BrandsControllerTest < ActionDispatch::IntegrationTest
  test 'succeed on index path' do
    get calendar_path,
        headers: { 'Turbo-Frame': 'a_turbo_frame' },
        params: { year: '2022', month: '7', id: 'an_id', input_id: 'an_input_id' }
    assert_response :success
  end
end
