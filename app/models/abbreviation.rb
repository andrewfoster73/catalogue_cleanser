# frozen_string_literal: true

class Abbreviation < ApplicationRecord
  belongs_to :dictionary_entry

  audited associated_with: :dictionary_entry

  validates :letters, presence: true, uniqueness: true
end
