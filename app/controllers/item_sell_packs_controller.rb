# frozen_string_literal: true

class ItemSellPacksController < ResourcesController
  private

  # Only allow a list of trusted parameters through.
  def permitted_params
    %i[name canonical]
  end
end
