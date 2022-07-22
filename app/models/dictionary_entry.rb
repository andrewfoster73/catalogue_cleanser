# frozen_string_literal: true

class DictionaryEntry < ApplicationRecord
  has_many :abbreviations, dependent: :destroy
  has_associated_audits

  audited

  before_validation :clean

  validates :phrase, presence: true, uniqueness: true

  def to_s
    phrase
  end

  protected

  def clean
    # Allowed characters are a-z, A-Z, 0-9, full stop, parentheses, dash, comma, apostrophe and space
    assign_attributes(phrase: phrase&.tr('^a-zA-Z0-9\.\(\)\-,\' ', ' ')&.squeeze(' ')&.strip)
  end
end
