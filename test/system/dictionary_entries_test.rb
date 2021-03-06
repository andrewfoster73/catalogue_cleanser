# frozen_string_literal: true

require 'application_system_test_case'

class DictionaryEntriesTest < ApplicationSystemTestCase
  setup do
    @dictionary_entry = dictionary_entries(:one)
  end

  test 'redirects if not logged in' do
    visit dictionary_entries_url
    assert_current_path(root_url)
  end

  test 'visiting the index' do
    login
    visit dictionary_entries_url
    assert_selector 'h1', text: 'Dictionary entries'
  end

  test 'should create dictionary entry' do
    login
    visit dictionary_entries_url
    click_on 'New dictionary entry'

    check 'Canonical' if @dictionary_entry.canonical
    fill_in 'Phrase', with: "a #{@dictionary_entry.phrase}"
    click_on 'Create Dictionary entry'

    assert_text "Dictionary entry 'a #{@dictionary_entry}' was successfully created"
    click_on 'Back'
  end

  test 'should update Dictionary entry' do
    login
    visit dictionary_entry_url(@dictionary_entry)
    click_on 'Edit this dictionary entry', match: :first

    check 'Canonical' if @dictionary_entry.canonical
    fill_in 'Phrase', with: @dictionary_entry.phrase
    click_on 'Update Dictionary entry'

    assert_text "Dictionary entry '#{@dictionary_entry}' was successfully updated"
    click_on 'Back'
  end

  test 'should destroy Dictionary entry' do
    login
    visit dictionary_entry_url(@dictionary_entry)
    click_on 'Destroy this dictionary entry', match: :first

    assert_text "Dictionary entry '#{@dictionary_entry}' was successfully deleted"
  end
end
