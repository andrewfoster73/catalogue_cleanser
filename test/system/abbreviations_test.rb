# frozen_string_literal: true

require 'application_system_test_case'

class AbbreviationsTest < ApplicationSystemTestCase
  setup do
    @abbreviation = abbreviations(:one)
  end

  test 'redirects if not logged in' do
    visit abbreviations_url
    assert_current_path(root_url)
  end

  test 'visiting the index' do
    login
    visit abbreviations_url
    assert_selector 'h1', text: 'abbreviations'
  end

  test 'should create abbreviation' do
    login
    visit abbreviations_url
    click_on 'New abbreviation'

    fill_in 'Dictionary entry', with: @abbreviation.dictionary_entry_id
    fill_in 'Letters', with: "some #{@abbreviation.letters}"
    click_on 'Create Abbreviation'

    assert_text "Abbreviation 'some #{@abbreviation}' was successfully created"
    click_on 'Back'
  end

  test 'should update Abbreviation' do
    login
    visit abbreviation_url(@abbreviation)
    click_on 'Edit this abbreviation', match: :first

    fill_in 'Dictionary entry', with: @abbreviation.dictionary_entry_id
    fill_in 'Letters', with: @abbreviation.letters
    click_on 'Update Abbreviation'

    assert_text "Abbreviation '#{@abbreviation}' was successfully updated"
    click_on 'Back'
  end

  test 'should destroy Abbreviation' do
    login
    visit abbreviation_url(@abbreviation)
    click_on 'Destroy this abbreviation', match: :first

    assert_text "Abbreviation '#{@abbreviation}' was successfully deleted"
  end
end
