# frozen_string_literal: true

FactoryBot.define do
  factory :external_catalogue, class: 'External::Catalogue' do
    id { 1 }
    title { 'Master Catalogue' }
    owner_id { 1 }
    owner_type { 'Organisation' }
  end
end
