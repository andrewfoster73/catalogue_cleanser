# frozen_string_literal: true

FactoryBot.define do
  factory :item_sell_pack_alias do
    association :item_sell_pack
    add_attribute(:alias) { 'ctn' }
    confirmed { true }
  end
end
