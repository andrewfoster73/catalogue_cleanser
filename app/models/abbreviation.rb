# frozen_string_literal: true

class Abbreviation < ApplicationRecord
  belongs_to :dictionary_entry

  audited associated_with: :dictionary_entry

  before_validation :clean

  validates :letters, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at dictionary_entry_id id letters updated_at]
  end

  def parent
    dictionary_entry
  end

  def to_s
    "#{letters} (#{dictionary_entry})"
  end

  protected

  def clean
    # Allowed characters are a-z, A-Z, 0-9, slash, full stop and space
    assign_attributes(letters: letters&.tr('^a-zA-Z/0-9\. ', ' ')&.squeeze(' ')&.strip)
  end
end
