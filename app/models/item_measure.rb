# frozen_string_literal: true

class ItemMeasure < ApplicationRecord
  has_many :item_measure_aliases, dependent: :destroy
  has_associated_audits

  audited

  before_validation :clean

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
