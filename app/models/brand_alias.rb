# frozen_string_literal: true

class BrandAlias < ApplicationRecord
  belongs_to :brand

  audited associated_with: :brand

  before_validation :clean

  validates :alias, presence: true, uniqueness: true
  validates :count, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  def parent
    brand
  end

  def to_s
    "#{self.alias} (#{brand})"
  end

  protected

  def clean
    # Allowed characters are a-z, A-Z, 0-9, full stop, parentheses, dash, comma and space
    assign_attributes(alias: self.alias&.tr('^a-zA-Z0-9\.\(\)\-, ', ' ')&.squeeze(' ')&.strip)
  end
end
