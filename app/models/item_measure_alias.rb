# frozen_string_literal: true

class ItemMeasureAlias < ApplicationRecord
  include Broadcast
  include NestedBroadcast
  include Importable

  belongs_to :item_measure, counter_cache: true

  audited associated_with: :item_measure

  before_validation :clean, unless: :imported?

  validates :alias, presence: true, uniqueness: true

  # The parent object to use whenever the ItemMeasureAlias appears nested
  # @return [ItemMeasure] the item measure this alias belongs to
  def parent
    item_measure
  end

  # A string representation of the ItemMeasureAlias that is used whenever an instance is converted to a string
  # @return [String] the alias concatenated with the string description of the item measure it belongs to
  def to_s
    "#{self.alias} (#{item_measure})"
  end

  protected

  def clean
    # Allowed characters are a-z and space
    assign_attributes(alias: self.alias&.downcase&.tr('^a-z ', ' ')&.squeeze(' ')&.strip)
  end
end
