# frozen_string_literal: true

class BrandAlias < ApplicationRecord
  include Broadcast
  include NestedBroadcast
  include Importable

  belongs_to :brand

  audited associated_with: :brand

  before_validation :clean, if: -> { data_source == 'manual' }

  validates :alias, presence: true, uniqueness: true
  validates :count, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # The parent object to use whenever the BrandAlias appears nested
  # @return [Brand] the brand this alias belongs to
  def parent
    brand
  end

  # A string representation of the BrandAlias that is used whenever an instance is converted to a string
  # @return [String] the alias concatenated with the string description of the brand it belongs to
  def to_s
    "#{self.alias} (#{brand})"
  end

  protected

  def clean
    # Allowed characters are a-z, A-Z, 0-9, full stop, parentheses, dash, comma, apostrophe, forward slash and space
    assign_attributes(alias: self.alias&.tr('^a-zA-Z0-9\.\(\)\-,\'/ ', ' ')&.squeeze(' ')&.strip)
  end
end
