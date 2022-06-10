# frozen_string_literal: true

class AbbreviationsController < ResourcesController
  private

  # Only allow a list of trusted parameters through.
  def permitted_params
    %i[dictionary_entry_id letters]
  end
end
