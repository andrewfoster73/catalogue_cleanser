# frozen_string_literal: true

class ItemMeasuresController < ResourcesController
  private

  def collection_preloads
    [:item_measure_aliases]
  end

  # Only allow a list of trusted parameters through.
  def permitted_params
    super | %i[name canonical]
  end
end
