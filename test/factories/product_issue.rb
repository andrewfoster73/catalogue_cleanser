# frozen_string_literal: true

FactoryBot.define do
  factory :product_issue do
    association :product, factory: :product
    type { 'ProductIssues::MissingCompulsory' }

    trait :pending do
      status { :pending }
    end

    trait :ignored do
      status { :ignored }
    end

    trait :confirmed do
      status { :confirmed }
    end

    trait :fixed do
      status { :fixed }
    end
  end
end
