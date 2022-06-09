# frozen_string_literal: true

class DictionaryEntry < ApplicationRecord
  has_many :abbreviations, dependent: :destroy
end
