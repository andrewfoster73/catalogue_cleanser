# frozen_string_literal: true

class ItemSellPackAlias < ApplicationRecord
  belongs_to :item_sell_pack

  audited associated_with: :item_sell_pack

  before_validation :clean

  validates :alias, presence: true, uniqueness: true

  protected

  def clean
    # Allowed characters are a-z and space
    assign_attributes(alias: self.alias&.downcase&.tr('^a-z ', ' ')&.squeeze(' ')&.strip)
  end
end
