# frozen_string_literal: true

json.array!(@dictionary_entries, partial: 'dictionary_entries/dictionary_entry', as: :dictionary_entry)
