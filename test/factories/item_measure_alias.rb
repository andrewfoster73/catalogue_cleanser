# frozen_string_literal: true

FactoryBot.define do
  factory :item_measure_alias do
    association :item_measure, strategy: :build
    add_attribute(:alias) { 'millilitre' }
    confirmed { true }
  end
end
