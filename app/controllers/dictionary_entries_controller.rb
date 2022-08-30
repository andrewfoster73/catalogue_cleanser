# frozen_string_literal: true

class DictionaryEntriesController < ResourcesController
  private

  # Only allow a list of trusted parameters through.
  def permitted_params
    super | %i[phrase canonical]
  end
end
