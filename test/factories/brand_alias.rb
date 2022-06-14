# frozen_string_literal: true

FactoryBot.define do
  factory :brand_alias do
    association :brand
    add_attribute(:alias) { 'hnz' }
    confirmed { true }
  end
end
