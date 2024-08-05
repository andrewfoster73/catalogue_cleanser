# frozen_string_literal: true

class ProductsController < ResourcesController
  include TurboActions
  include ManuallyEditable

  private

  def destroy_resource
    @resource.discard!
  end

  def update_resource
    @resource.update_and_propagate(resource_params)
    @resource.resolve_issues!
  end

  def collection_preloads
    [{ product_translations: :product_issues }, :product_duplicates, :product_issues]
  end

  # Only allow a list of trusted parameters through.
  def permitted_params
    super | %i[
      item_description brand item_size item_measure item_pack_name item_sell_quantity item_sell_pack_name category_id
    ]
  end

  def default_sort
    return if custom_sort_clause.present?

    'item_description asc'
  end

  def custom_sort_clause
    return nil if params.dig('q', 'item_description_cont').nil?

    [Arel.sql('similarity(?, item_description) DESC'), params.dig('q', 'item_description_cont')]
  end

  def default_filters
    { kept: true }
  end
end
