# frozen_string_literal: true

class ProductDuplicate < ApplicationRecord
  belongs_to :product, inverse_of: :product_duplicates, counter_cache: true
  # belongs_to :canonical_product
  # belongs_to :mapped_product

  audited associated_with: :product

  delegate :to_s, to: :product
end
