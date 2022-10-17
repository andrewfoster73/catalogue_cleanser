# frozen_string_literal: true

class ProductIssuesController < ResourcesController
  include TurboActions
  include Nested

  private

  def collection_preloads
    [:product]
  end

  def collection_path_method
    return super unless nested?

    :product_product_issues_path
  end

  # Only allow a list of trusted parameters through.
  def permitted_params
    super | %i[status]
  end

  def filter_url
    return unless nested?

    @filter_url ||= public_send(collection_path_method, product_id: @parent)
  end

  def parent_class
    @parent_class ||= parent_class_name.safe_constantize
  end

  def parent
    return unless parent_id

    @parent ||= parent_class.find_by(id: parent_id)
  end

  def parent_id
    params[:product_id] ||
      params.dig(:product_issue, :product_id) ||
      params[:product_translation_id] ||
      params.dig(:product_issue, :product_translation_id)
  end

  def parent_class_name
    return 'Product' if params[:product_id] || params.dig(:product_issue, :product_id)

    'ProductTranslation'
  end

  def redirect_after_update
    redirect_to(collection_url(format: :html),
                success: t('actions.update.success', name: resource_human_name, resource: @resource.to_s)
               )
  end
end
