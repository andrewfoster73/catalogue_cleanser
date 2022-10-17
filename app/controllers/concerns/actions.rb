# frozen_string_literal: true

# DRY up controllers by extracting generic action methods that can be overridden if necessary
module Actions
  extend ActiveSupport::Concern

  # GET /collection or /collection.json
  def index; end

  # GET /collection/1 or /collection/1.json
  def show; end

  # @deprecated The UI will render a modal instead from the index page
  def new
    @resource = resource_class.new
  end

  # GET /collection/1/edit
  def edit; end

  # POST /collection or /collection.json
  def create
    build_resource

    respond_to do |format|
      if create_resource
        format.html do
          redirect_to(
            resource_url(@resource, { format: :html }),
            success: t('actions.create.success', name: resource_human_name, resource: @resource.to_s)
          )
        end
        format.json { render(:show, status: :created, location: @resource) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @resource.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /collection/1 or /collection/1.json
  def update
    respond_to do |format|
      if update_resource
        format.html do
          redirect_to(
            resource_url(@resource),
            success: t('actions.update.success', name: resource_human_name, resource: @resource.to_s)
          )
        end
        format.json { render(:show, status: :ok, location: @resource) }
      else
        format.html do
          flash.now[:error] = t('actions.update.error', name: resource_human_name)
          render(:edit, status: :unprocessable_entity, error: t('actions.update.error', name: resource_human_name))
        end
        format.json { render(json: @resource.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /collection/1 or /collection/1.json
  def destroy
    destroy_resource

    respond_to do |format|
      format.html do
        redirect_to(
          collection_url,
          success: t('actions.destroy.success', name: resource_human_name, resource: @resource.to_s)
        )
      end
      format.json { head(:no_content) }
    end
  end
end
