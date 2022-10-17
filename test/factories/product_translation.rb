# frozen_string_literal: true

FactoryBot.define do
  factory :product_translation do
    association :product, factory: :product
    locale { 'en' }
    item_description { 'Lager' }
    brand { 'Innis & Gunn' }
    item_size { 440.0 }
    item_measure { 'ml' }
    item_pack_name { 'can' }
    item_sell_quantity { 6 }
    item_sell_pack_name { 'carton' }
  end
end
