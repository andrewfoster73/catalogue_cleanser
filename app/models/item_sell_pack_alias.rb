# frozen_string_literal: true

class ItemSellPackAlias < ApplicationRecord
  belongs_to :item_sell_pack

  audited associated_with: :item_sell_pack

  validates :alias, presence: true, uniqueness: true
end
