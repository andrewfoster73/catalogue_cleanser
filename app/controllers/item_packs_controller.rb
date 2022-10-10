# frozen_string_literal: true

class ItemPacksController < ResourcesController
  private

  def collection_preloads
    [:item_pack_aliases]
  end

  # Only allow a list of trusted parameters through.
  def permitted_params
    super | %i[name canonical]
  end
end
