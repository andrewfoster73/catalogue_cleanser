# frozen_string_literal: true

require 'test_helper'

class DictionaryEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dictionary_entry = dictionary_entries(:one)
  end

  test 'should redirect if not authenticated' do
    get dictionary_entries_url
    assert_redirected_to :root
  end

  test 'should get index' do
    authenticate
    get dictionary_entries_url
    assert_response :success
  end

  test 'should get new' do
    authenticate
    get new_dictionary_entry_url
    assert_response :success
  end

  test 'should create dictionary_entry' do
    authenticate
    assert_difference('DictionaryEntry.count') do
      post dictionary_entries_url,
           params: {
             dictionary_entry: {
               canonical: @dictionary_entry.canonical,
               phrase: "a #{@dictionary_entry.phrase}"
             }
           }
    end

    assert_redirected_to dictionary_entry_url(DictionaryEntry.last, format: :html)
  end

  test 'should show dictionary_entry' do
    authenticate
    get dictionary_entry_url(@dictionary_entry)
    assert_response :success
  end

  test 'should get edit' do
    authenticate
    get edit_dictionary_entry_url(@dictionary_entry)
    assert_response :success
  end

  test 'should update dictionary_entry' do
    authenticate
    patch dictionary_entry_url(@dictionary_entry),
          params: { dictionary_entry: { canonical: @dictionary_entry.canonical, phrase: @dictionary_entry.phrase } }
    assert_redirected_to dictionary_entry_url(@dictionary_entry)
  end

  test 'should destroy dictionary_entry' do
    authenticate
    assert_difference('DictionaryEntry.count', -1) do
      delete dictionary_entry_url(@dictionary_entry)
    end

    assert_redirected_to dictionary_entries_url
  end
end
