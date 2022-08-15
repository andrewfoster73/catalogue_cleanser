# frozen_string_literal: true

class ItemSellPacksController < ResourcesController
  include TurboActions

  private

  # Only allow a list of trusted parameters through.
  def permitted_params
    %i[name canonical]
  end

  def default_sort
    'name asc'
  end

  def default_filters
    super.merge({ canonical_true: '1', canonical_not_true: '0' })
  end
end
