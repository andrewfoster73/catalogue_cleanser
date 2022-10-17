# frozen_string_literal: true

FactoryBot.define do
  factory :product_issue do
    association :product, factory: :product
  end
end
