# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'Saul' }
    last_name { 'Goodman' }
    email { 'saul.goodman@example.com' }
  end
end
