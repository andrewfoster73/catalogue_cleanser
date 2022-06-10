# frozen_string_literal: true

json.array!(@collection, partial: 'abbreviations/abbreviation', as: :abbreviation)
