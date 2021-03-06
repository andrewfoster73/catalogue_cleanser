# frozen_string_literal: true

# DRY up controllers by extracting generic action methods that can be overridden if necessary
module Actions
  extend ActiveSupport::Concern

  # GET /collection or /collection.json
  def index; end

  # GET /collection/1 or /collection/1.json
  def show; end

  # GET /collection/new
  def new
    @resource = resource_class.new
  end

  # GET /collection/1/edit
  def edit; end

  # POST /collection or /collection.json
  def create
    @resource = resource_class.new(resource_params)

    respond_to do |format|
      if @resource.save
        format.html do
          redirect_to(resource_url(@resource, { format: :html }),
                      success: "#{resource_human_name} '#{@resource}' was successfully created."
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
      if @resource.update(resource_params)
        format.html do
          redirect_to(resource_url(@resource),
                      success: "#{resource_human_name} '#{@resource}' was successfully updated."
                     )
        end
        format.json { render(:show, status: :ok, location: @resource) }
      else
        format.html do
          flash.now[:error] = "#{resource_human_name} could not be updated."
          render(:edit, status: :unprocessable_entity, error: "#{resource_human_name} could not be updated.")
        end
        format.json { render(json: @resource.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /collection/1 or /collection/1.json
  def destroy
    @resource.destroy!

    respond_to do |format|
      format.html do
        redirect_to(collection_url, success: "#{resource_human_name} '#{@resource}' was successfully deleted.")
      end
      format.json { head(:no_content) }
    end
  end
end
