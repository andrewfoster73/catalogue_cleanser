# frozen_string_literal: true

class BrandAliasesController < ResourcesController
  private

  # Only allow a list of trusted parameters through.
  def permitted_params
    %i[brand_id alias confirmed count]
  end
end
