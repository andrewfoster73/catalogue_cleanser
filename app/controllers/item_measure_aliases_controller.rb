# frozen_string_literal: true

class ItemMeasureAliasesController < ResourcesController
  private

  # Only allow a list of trusted parameters through.
  def permitted_params
    super | %i[item_measure_id alias confirmed]
  end
end
