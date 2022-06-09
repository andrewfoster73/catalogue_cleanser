# frozen_string_literal: true

class Brand < ApplicationRecord
  has_many :brand_aliases, dependent: :destroy
end
