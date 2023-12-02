# frozen_string_literal: true

FactoryBot.define do
  factory :product_duplicate do
    association :product, factory: :product
    association :potential_duplicate_product, factory: :product, strategy: :build
  end
end
