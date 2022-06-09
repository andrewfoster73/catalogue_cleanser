# frozen_string_literal: true

json.extract!(dictionary_entry, :id, :phrase, :canonical, :created_at, :updated_at)
json.url(dictionary_entry_url(dictionary_entry, format: :json))
