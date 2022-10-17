# frozen_string_literal: true

class ItemMeasureAlias < ApplicationRecord
  belongs_to :item_measure

  audited associated_with: :item_measure

  before_validation :clean

  validates :alias, presence: true, uniqueness: true

  def parent
    item_measure
  end

  def to_s
    "#{self.alias} (#{item_measure})"
  end

  protected

  def clean
    # Allowed characters are a-z and space
    assign_attributes(alias: self.alias&.downcase&.tr('^a-z ', ' ')&.squeeze(' ')&.strip)
  end
end
