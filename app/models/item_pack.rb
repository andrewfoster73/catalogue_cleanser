# frozen_string_literal: true

class ItemPack < ApplicationRecord
  has_many :item_pack_aliases, dependent: :destroy
  has_associated_audits

  audited
end
