# frozen_string_literal: true

# DRY up controllers by using "resource" for a single record, "collection" for all records
module Resources
  extend ActiveSupport::Concern

  # Rubocop does not like show/edit/update/destroy/index when used via a Concern
  # rubocop:disable Rails/LexicallyScopedActionFilter
  included do
    before_action :set_resource, only: %i[show edit update destroy]
    before_action :set_collection, only: %i[index]
  end
  # rubocop:enable Rails/LexicallyScopedActionFilter

  private

  def set_collection
    @collection = resource_class.all
  end

  def set_resource
    @resource = resource_class.find(params[:id])
    @resource.form_authenticity_token = form_authenticity_token
  end

  def resource_class
    # eg ItemSellPacksController -> ItemSellPack
    @resource_class ||= controller_name.gsub('Controller', '').singularize.classify.safe_constantize
  end

  def resource_name
    # eg ItemSellPack -> item_sell_pack
    @resource_name ||= resource_class.name.underscore.to_sym
  end

  def resource_human_name
    # eg ItemSellPack -> Item sell pack
    @resource_human_name ||= resource_class.model_name.human
  end
end
