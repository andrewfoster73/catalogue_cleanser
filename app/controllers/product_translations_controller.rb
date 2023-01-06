# frozen_string_literal: true

class ProductTranslationsController < ResourcesController
  include TurboActions
  include Nested
  include ManuallyEditable

  private

  def update_resource
    super
    @resource.product.resolve_issues!
    # Create task to update P+ Product Translation
  end

  def collection_preloads
    [{ product: %i[product_translations product_issues] }, :product_issues]
  end

  def collection_path_method
    return super unless nested?

    :product_product_translations_path
  end

  # Only allow a list of trusted parameters through.
  def permitted_params
    super |
      %i[locale item_description brand item_size item_measure item_pack_name item_sell_quantity item_sell_pack_name]
  end

  def default_sort
    'locale asc'
  end

  def filter_url
    return unless nested?

    @filter_url ||= public_send(collection_path_method, product_id: @parent)
  end

  def parent_class
    @parent_class ||= Product
  end

  def parent
    return unless parent_id

    @parent ||= parent_class.find_by(id: parent_id)
  end

  def parent_id
    params[:product_id] || params.dig(:product_translation, :product_id)
  end

  def navigation_path
    return products_url if nested?

    super
  end
end
