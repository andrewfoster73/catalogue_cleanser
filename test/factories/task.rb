# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    type { 'TestTask' }

    trait :complete do
      status { :complete }
    end

    trait :pending do
      status { :pending }
    end

    trait :processing do
      status { :processing }
    end

    trait :error do
      status { :error }
    end
  end
end
