# frozen_string_literal: true

class ItemMeasure < ApplicationRecord
  has_many :item_measure_aliases, dependent: :destroy, strict_loading: true
  has_associated_audits

  audited

  before_validation :clean, if: -> { data_source == 'manual' }

  validates :name, presence: true, uniqueness: true

  def to_s
    name
  end

  protected

  def clean
    # Allowed characters are a-z and space
    assign_attributes(name: name&.downcase&.tr('^a-z ', ' ')&.squeeze(' ')&.strip)
  end
end
