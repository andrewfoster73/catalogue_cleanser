# frozen_string_literal: true

class ProductTranslationsController < ResourcesController
  include TurboActions
  include Nested

  private

  def collection_preloads
    [:product]
  end

  def collection_path_method
    return super unless nested?

    :product_product_translations_path
  end

  # Only allow a list of trusted parameters through.
  def permitted_params
    super | %i[locale item_description brand item_size item_measure item_pack_name item_sell_size item_sell_pack_name]
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
end
