# frozen_string_literal: true

class ItemSellPacksController < ResourcesController
  def destroy
    @resource.destroy!

    respond_to do |format|
      format.html { redirect_to(collection_url, notice: "#{resource_human_name} was successfully destroyed.") }
      format.json do
        flash[:notice] = "#{resource_human_name} was successfully destroyed."
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
end
