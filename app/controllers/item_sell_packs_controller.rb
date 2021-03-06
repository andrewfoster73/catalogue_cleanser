# frozen_string_literal: true

class ItemSellPacksController < ResourcesController
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

  def update
    respond_to do |format|
      if @resource.update(resource_params)
        format.html do
          redirect_to(resource_url(@resource, { format: :html }),
                      success: "#{resource_human_name} '#{@resource}' was successfully updated."
                     )
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
          flash.now[:error] = "#{resource_human_name} could not be updated."
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

  def destroy
    @resource.destroy!

    respond_to do |format|
      format.html do
        redirect_to(collection_url, success: "#{resource_human_name} '#{@resource}' was successfully deleted.")
      end
      format.json do
        flash[:success] = "#{resource_human_name} '#{@resource}' was successfully deleted."
        head(:no_content)
      end
      format.turbo_stream {}
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def permitted_params
    %i[name canonical]
  end

  def default_sort
    'name asc'
  end

  def default_filters
    { canonical_true: '1', canonical_not_true: '0' }
  end

  def editable_cell_attribute
    resource_params.keys.first
  end

  def editable_cell_formatter
    resource_class.attribute_types[editable_cell_attribute].type
  end
end
