# frozen_string_literal: true

class ItemPacksController < ResourcesController
  include TurboActions

  private

  def collection_preloads
    [:item_pack_aliases]
  end

  # Only allow a list of trusted parameters through.
  def permitted_params
    super | %i[name canonical]
  end

  def default_sort
    'name asc'
  end

  def default_filters
    super.merge({ canonical_true: '1', canonical_not_true: '0' })
  end
end
