# frozen_string_literal: true

json.extract!(abbreviation, :id, :dictionary_entry_id, :letters, :created_at, :updated_at)
json.url(abbreviation_url(abbreviation, format: :json))
