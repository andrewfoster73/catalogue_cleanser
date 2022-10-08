# frozen_string_literal: true

FactoryBot.define do
  factory :external_catalogued_product, class: 'External::CataloguedProduct' do
    association :external_product, factory: :external_product
    catalogue_id { 1 }
  end
end
