# frozen_string_literal: true

class ItemMeasuresController < ResourcesController
  private

  # Only allow a list of trusted parameters through.
  def permitted_params
    %i[name canonical]
  end
end
