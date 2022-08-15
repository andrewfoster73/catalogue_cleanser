# frozen_string_literal: true

class ItemSellPackAliasesController < ResourcesController
  include TurboActions
  include Nested

  private

  def collection_preloads
    [:item_sell_pack]
  end

  def collection_path_method
    return super unless nested?

    :item_sell_pack_item_sell_pack_aliases_path
  end

  # Only allow a list of trusted parameters through.
  def permitted_params
    %i[item_sell_pack_id alias confirmed]
  end

  def default_sort
    'alias asc'
  end

  def filter_url
    return unless nested?

    @filter_url ||= public_send(collection_path_method, item_sell_pack_id: @parent)
  end

  def default_filters
    super.merge({ confirmed_true: '1', confirmed_not_true: '0' })
  end

  def parent_class
    @parent_class ||= ItemSellPack
  end

  def parent
    @parent ||=
      parent_class
      .find_by(id: params[:item_sell_pack_id] || params.dig(:item_sell_pack_alias, :item_sell_pack_id))
  end
end
