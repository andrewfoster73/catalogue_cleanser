# frozen_string_literal: true

class ItemSellPackAlias < ApplicationRecord
  include Broadcast
  include NestedBroadcast

  belongs_to :item_sell_pack, inverse_of: :item_sell_pack_aliases

  audited associated_with: :item_sell_pack

  before_validation :clean

  validates :alias, presence: true, uniqueness: true

  def parent
    item_sell_pack
  end

  def to_s
    self.alias
  end

  protected

  def clean
    # Allowed characters are a-z and space
    assign_attributes(alias: self.alias&.downcase&.tr('^a-z ', ' ')&.squeeze(' ')&.strip)
  end
end
