# frozen_string_literal: true

class DictionaryEntry < ApplicationRecord
  has_many :abbreviations, dependent: :destroy
  has_associated_audits

  audited

  validates :phrase, presence: true, uniqueness: true
end
