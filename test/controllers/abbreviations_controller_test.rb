# frozen_string_literal: true

require 'test_helper'

class AbbreviationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @abbreviation = abbreviations(:one)
  end

  test 'should redirect if not authenticated' do
    get abbreviations_url
    assert_redirected_to :root
  end

  test 'should get index' do
    authenticate
    get abbreviations_url
    assert_response :success
  end

  test 'should get new' do
    authenticate
    get new_abbreviation_url
    assert_response :success
  end

  test 'should create abbreviation' do
    authenticate
    assert_difference('Abbreviation.count') do
      post abbreviations_url,
           params: {
             abbreviation: {
               dictionary_entry_id: @abbreviation.dictionary_entry_id,
               letters: "some #{@abbreviation.letters}"
             }
           }
    end

    assert_redirected_to abbreviation_url(Abbreviation.last, format: :html)
  end

  test 'should show abbreviation' do
    authenticate
    get abbreviation_url(@abbreviation)
    assert_response :success
  end

  test 'should get edit' do
    authenticate
    get edit_abbreviation_url(@abbreviation)
    assert_response :success
  end

  test 'should update abbreviation' do
    authenticate
    patch abbreviation_url(@abbreviation),
          params: {
            abbreviation: {
              dictionary_entry_id: @abbreviation.dictionary_entry_id,
              letters: @abbreviation.letters
            }
          }
    assert_redirected_to abbreviation_url(@abbreviation)
  end

  test 'should destroy abbreviation' do
    authenticate
    assert_difference('Abbreviation.count', -1) do
      delete abbreviation_url(@abbreviation)
    end

    assert_redirected_to abbreviations_url
  end
end
