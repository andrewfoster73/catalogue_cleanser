# frozen_string_literal: true

FactoryBot.define do
  factory :dictionary_entry do
    phrase { 'Average Weight' }
    canonical { true }
  end
end
