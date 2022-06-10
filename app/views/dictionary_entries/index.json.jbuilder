# frozen_string_literal: true

json.array!(@collection, partial: 'dictionary_entries/dictionary_entry', as: :dictionary_entry)
