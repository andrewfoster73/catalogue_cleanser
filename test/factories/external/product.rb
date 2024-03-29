# frozen_string_literal: true

FactoryBot.define do
  factory :external_product, class: 'External::Product' do
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
