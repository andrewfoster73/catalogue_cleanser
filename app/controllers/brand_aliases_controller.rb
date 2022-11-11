# frozen_string_literal: true

class BrandAliasesController < ResourcesController
  include TurboActions
  include Nested

  private

  def collection_preloads
    [:brand]
  end

  def collection_path_method
    return super unless nested?

    :brand_brand_aliases_path
  end

  # Only allow a list of trusted parameters through.
  def permitted_params
    super | %i[brand_id alias confirmed count]
  end

  def default_sort
    'alias asc'
  end

  def filter_url
    return unless nested?

    @filter_url ||= public_send(collection_path_method, brand_id: @parent)
  end

  def default_filters
    super.merge({ confirmed_true: '1', confirmed_not_true: '0' })
  end

  def parent_class
    @parent_class ||= Brand
  end

  def parent
    return nil unless parent_id

    @parent ||= parent_class.find_by(id: parent_id)
  end

  def parent_id
    params[:brand_id] || params.dig(:brand_alias, :brand_id)
  end
end
