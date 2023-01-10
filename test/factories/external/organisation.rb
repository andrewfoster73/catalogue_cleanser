# frozen_string_literal: true

FactoryBot.define do
  factory :external_organisation, class: 'External::Organisation' do
    name { 'Dummy Organisation' }
  end
end
