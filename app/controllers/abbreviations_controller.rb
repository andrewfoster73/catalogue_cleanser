# frozen_string_literal: true

class AbbreviationsController < ResourcesController
  private

  # Only allow a list of trusted parameters through.
  def permitted_params
    super | %i[dictionary_entry_id letters]
  end
end
