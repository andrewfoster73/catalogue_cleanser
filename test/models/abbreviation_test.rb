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
end
