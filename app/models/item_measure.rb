# frozen_string_literal: true

class ItemMeasure < ApplicationRecord
  has_many :item_measure_aliases, dependent: :destroy
  has_associated_audits

  audited
end
