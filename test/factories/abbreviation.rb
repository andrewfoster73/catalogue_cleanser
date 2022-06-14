# frozen_string_literal: true

FactoryBot.define do
  factory :abbreviation do
    association :dictionary_entry
    letters { 'AW' }
  end
end
