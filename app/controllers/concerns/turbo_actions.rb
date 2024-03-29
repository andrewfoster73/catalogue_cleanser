# frozen_string_literal: true

# Temporary concern to handle new UI until all pages converted
module TurboActions
  extend ActiveSupport::Concern

  # GET /collection/1 or /collection/1.json
  def show
    respond_to do |format|
      format.html {}
      format.json {}
      format.turbo_stream do
        render(
          partial: 'editable_cell',
          locals: { attribute: editable_cell_attribute, formatter: editable_cell_formatter },
          status: :ok
        )
      end
    end
  end

  # PATCH/PUT /collection/1 or /collection/1.json
  def update
    respond_to do |format|
      if update_resource
        format.html do
          redirect_after_update
        end
        format.json { render(:show, status: :ok, location: @resource) }
        format.turbo_stream do
          render(
            partial: 'editable_cell',
            locals: { attribute: editable_cell_attribute, formatter: editable_cell_formatter },
            status: :ok
          )
        end
      else
        format.html do
          flash.now[:error] = t('actions.update.error', name: resource_human_name)
          render(:edit, status: :unprocessable_entity)
        end
        format.json { render(json: @resource.errors, status: :unprocessable_entity) }
        format.turbo_stream do
          render(
            partial: 'editable_cell',
            locals: {
              attribute: editable_cell_attribute,
              formatter: editable_cell_formatter,
              error: @resource.errors.full_messages.join(', ')
            },
            status: :ok
          )
        end
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
      format.json do
        flash[:success] = t('actions.destroy.success', name: resource_human_name, resource: @resource.to_s)
        head(:no_content)
      end
      format.turbo_stream {}
    end
  end

  private

  def editable_cell_attribute
    resource_params.keys.first
  end

  def editable_cell_formatter
    resource_class.attribute_types[editable_cell_attribute.to_s].type
  end

  def redirect_after_update
    redirect_to(resource_url(@resource, { format: :html }),
                success: t('actions.update.success', name: resource_human_name, resource: @resource.to_s)
               )
  end
end
