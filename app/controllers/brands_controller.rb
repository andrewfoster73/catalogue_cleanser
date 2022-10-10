# frozen_string_literal: true

class BrandsController < ResourcesController
  private

  def collection_preloads
    [:brand_aliases]
  end

  # Only allow a list of trusted parameters through.
  def permitted_params
    super | %i[name canonical count]
  end
end
