# frozen_string_literal: true

FactoryBot.define do
  factory :item_pack_alias do
    association :item_pack
    add_attribute(:alias) { 'ea' }
    confirmed { true }
  end
end
