# frozen_string_literal: true

class ProductsController < ResourcesController
  include TurboActions

  private

  def collection_preloads
    [:product_translations, :product_duplicates]
  end

  # Only allow a list of trusted parameters through.
  def permitted_params
    super | %i[item_description brand item_size item_measure item_pack_name item_sell_quantity item_sell_pack_name]
  end

  def default_sort
    'item_description asc'
  end
end
