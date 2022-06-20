# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    full_name { 'Saul Goodman' }
    email { 'saul.goodman@example.com' }
  end
end
