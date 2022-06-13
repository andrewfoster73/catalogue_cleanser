# frozen_string_literal: true

class ItemMeasureAlias < ApplicationRecord
  belongs_to :item_measure

  audited associated_with: :item_measure
end
