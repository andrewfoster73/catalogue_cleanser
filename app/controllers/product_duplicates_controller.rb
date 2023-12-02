# frozen_string_literal: true

class ProductDuplicatesController < ResourcesController
  include TurboActions
  include Nested

  private

  def collection_preloads
    %i[product potential_duplicate_product]
  end

  def collection_path_method
    return super unless nested?

    :product_product_duplicates_path
  end

  # Only allow a list of trusted parameters through.
  def permitted_params
    super | %i[action mapped_product_id]
  end

  def filter_url
    return unless nested?

    @filter_url ||= public_send(collection_path_method, product_id: @parent)
  end

  def default_sort
    'certainty_percentage desc'
  end

  def parent_class
    @parent_class ||= Product
  end

  def parent
    return unless parent_id

    @parent ||= parent_class.find_by(id: parent_id)
  end

  def parent_id
    params[:product_id] || params.dig(:product_duplicate, :product_id)
  end

  def redirect_after_update
    redirect_to(collection_url(format: :html),
                success: t('actions.update.success', name: resource_human_name, resource: @resource.to_s)
               )
  end

  def navigation_path
    return products_url if nested?

    super
  end
end
