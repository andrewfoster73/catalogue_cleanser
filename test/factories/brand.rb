# frozen_string_literal: true

FactoryBot.define do
  factory :brand do
    name { 'Heinz' }
    canonical { true }
  end
end
