# frozen_string_literal: true

class ItemPackAlias < ApplicationRecord
  belongs_to :item_pack

  audited associated_with: :item_pack

  before_validation :clean

  validates :alias, presence: true, uniqueness: true

  def to_s
    self.alias
  end

  protected

  def clean
    # Allowed characters are a-z and space
    assign_attributes(alias: self.alias&.downcase&.tr('^a-z ', ' ')&.squeeze(' ')&.strip)
  end
end
