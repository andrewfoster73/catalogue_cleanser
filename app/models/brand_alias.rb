# frozen_string_literal: true

class BrandAlias < ApplicationRecord
  belongs_to :brand

  audited associated_with: :brand
end
