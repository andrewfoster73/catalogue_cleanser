# frozen_string_literal: true

class ItemPackAliasesController < ResourcesController
  include TurboActions
  include Nested

  private

  def collection_preloads
    [:item_pack]
  end

  def collection_path_method
    return super unless nested?

    :item_pack_item_pack_aliases_path
  end

  # Only allow a list of trusted parameters through.
  def permitted_params
    super | %i[item_pack_id alias confirmed]
  end

  def default_sort
    'alias asc'
  end

  def filter_url
    return unless nested?

    @filter_url ||= public_send(collection_path_method, item_pack_id: @parent)
  end

  def default_filters
    super.merge({ confirmed_true: '1', confirmed_not_true: '0' })
  end

  def parent_class
    @parent_class ||= ItemPack
  end

  def parent
    return nil unless parent_id

    @parent ||= parent_class.find_by(id: parent_id)
  end

  def parent_id
    params[:item_pack_id] || params.dig(:item_pack_alias, :item_pack_id)
  end

  def navigation_path
    return item_packs_url if nested?

    super
  end
end
