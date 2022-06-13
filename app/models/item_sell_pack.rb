# frozen_string_literal: true

class ItemSellPack < ApplicationRecord
  has_many :item_sell_pack_aliases, dependent: :destroy
  has_associated_audits

  audited
end
