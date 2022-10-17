# frozen_string_literal: true

require 'test_helper'

class DictionaryEntryTest < ActiveSupport::TestCase
  test 'phrase presence validation' do
    dictionary_entry = build(:dictionary_entry, phrase: nil, canonical: nil)
    assert_not(dictionary_entry.save, 'Saved the dictionary entry without required attributes')
  end

  test 'name uniqueness validation' do
    # NOTE: there is a Dictionary Entry with a phrase of 'first phrase' already in the fixtures
    dictionary_entry = build(:dictionary_entry, phrase: 'first phrase', canonical: nil)
    assert_not(dictionary_entry.save, 'Saved the dictionary entry using a duplicate name')
  end

  test 'cleaning' do
    dictionary_entry = build(:dictionary_entry, phrase: " Conway's Law   \n")
    dictionary_entry.valid?
    assert_equal("Conway's Law", dictionary_entry.phrase, 'Dictionary entry contains illegal whitespace')
  end

  test 'to_s' do
    dictionary_entry = build(:dictionary_entry, phrase: "Conway's Law")
    assert_equal("Conway's Law", dictionary_entry.to_s, 'Dictionary entry to string should be the phrase')
  end
end
