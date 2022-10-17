# frozen_string_literal: true

require 'test_helper'

class AbbreviationTest < ActiveSupport::TestCase
  test 'letters presence validation' do
    abbreviation = build(:abbreviation, letters: nil)
    assert_not(abbreviation.save, 'Saved the abbreviation letters without required attributes')
  end

  test 'letters uniqueness validation' do
    # NOTE: there is an Abbreviation with a name of 'o.n.e.' already in the fixtures
    abbreviation = build(:abbreviation, letters: 'o.n.e.')
    assert_not(abbreviation.save, 'Saved the abbreviation letters using a duplicate name')
  end

  test 'cleaning' do
    abbreviation = build(:abbreviation, letters: " C.L.  \n")
    abbreviation.valid?
    assert_equal('C.L.', abbreviation.letters, 'Abbreviation letters contains illegal whitespace')
  end

  test 'parent' do
    dictionary_entry = build(:dictionary_entry, phrase: 'skin on')
    abbreviation = build(:abbreviation, dictionary_entry: dictionary_entry, letters: 's/on')
    assert_equal(dictionary_entry, abbreviation.parent)
  end

  test 'to_s' do
    dictionary_entry = build(:dictionary_entry, phrase: 'skin on')
    abbreviation = build(:abbreviation, dictionary_entry: dictionary_entry, letters: 's/on')
    assert_equal('s/on (skin on)', abbreviation.to_s)
  end
end
