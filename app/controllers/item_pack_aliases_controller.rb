# frozen_string_literal: true

class ItemPackAliasesController < ResourcesController
  private

  # Only allow a list of trusted parameters through.
  def permitted_params
    %i[item_pack_id alias confirmed]
  end
end
