# frozen_string_literal: true

class ItemPackAlias < ApplicationRecord
  belongs_to :item_pack

  audited associated_with: :item_pack

  validates :alias, presence: true, uniqueness: true
end
