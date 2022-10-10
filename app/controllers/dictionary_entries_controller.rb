# frozen_string_literal: true

class DictionaryEntriesController < ResourcesController
  private

  def collection_preloads
    [:abbreviations]
  end

  # Only allow a list of trusted parameters through.
  def permitted_params
    super | %i[phrase canonical]
  end
end
