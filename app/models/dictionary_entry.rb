# frozen_string_literal: true

class DictionaryEntry < ApplicationRecord
  has_many :abbreviations, dependent: :destroy, strict_loading: true
  has_associated_audits

  audited

  before_validation :clean

  validates :phrase, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    %w[abbreviations_count canonical created_at id phrase updated_at]
  end

  def to_s
    phrase
  end

  protected

  def clean
    # Allowed characters are a-z, A-Z, 0-9, full stop, parentheses, dash, comma, apostrophe and space
    assign_attributes(phrase: phrase&.tr('^a-zA-Z0-9\.\(\)\-,\' ', ' ')&.squeeze(' ')&.strip)
  end
end
