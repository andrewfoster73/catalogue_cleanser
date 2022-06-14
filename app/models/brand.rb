# frozen_string_literal: true

class Brand < ApplicationRecord
  has_many :brand_aliases, dependent: :destroy
  has_associated_audits

  audited

  before_validation :clean

  validates :name, presence: true, uniqueness: true
  validates :count, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  protected

  def clean
    # Allowed characters are a-z, A-Z, 0-9, full stop, parentheses, dash, comma and space
    assign_attributes(name: name&.tr('^a-zA-Z0-9\.\(\)\-, ', ' ')&.squeeze(' ')&.strip)
  end
end
