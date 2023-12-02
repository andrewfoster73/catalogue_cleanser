# frozen_string_literal: true

class ItemMeasure < ApplicationRecord
  include Broadcast
  include Importable

  has_many :item_measure_aliases, dependent: :destroy, strict_loading: true
  has_associated_audits

  audited unless: :imported?

  before_validation :clean, unless: :imported?

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    %w[canonical created_at data_source id item_measure_aliases_count name updated_at]
  end

  # A string representation of the Item Measure that is used whenever an instance is converted to a string
  # @return [String] the name of the Item Measure
  def to_s
    name
  end

  protected

  def clean
    # Allowed characters are a-z, A-Z, 0-9, % and space
    assign_attributes(name: name&.tr('^a-zA-Z0-9% ', ' ')&.squeeze(' ')&.strip)
  end
end
