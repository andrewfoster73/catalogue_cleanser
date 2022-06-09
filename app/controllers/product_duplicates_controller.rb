# frozen_string_literal: true

class ProductDuplicatesController < ApplicationController
  before_action :set_product_duplicate, only: %i[show edit update destroy]

  # GET /product_duplicates or /product_duplicates.json
  def index
    @product_duplicates = ProductDuplicate.all
  end

  # GET /product_duplicates/1 or /product_duplicates/1.json
  def show; end

  # GET /product_duplicates/new
  def new
    @product_duplicate = ProductDuplicate.new
  end

  # GET /product_duplicates/1/edit
  def edit; end

  # POST /product_duplicates or /product_duplicates.json
  def create
    @product_duplicate = ProductDuplicate.new(product_duplicate_params)

    respond_to do |format|
      if @product_duplicate.save
        format.html do
          redirect_to(product_duplicate_url(@product_duplicate), notice: 'Product duplicate was successfully created.')
        end
        format.json { render(:show, status: :created, location: @product_duplicate) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @product_duplicate.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /product_duplicates/1 or /product_duplicates/1.json
  def update
    respond_to do |format|
      if @product_duplicate.update(product_duplicate_params)
        format.html do
          redirect_to(product_duplicate_url(@product_duplicate), notice: 'Product duplicate was successfully updated.')
        end
        format.json { render(:show, status: :ok, location: @product_duplicate) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @product_duplicate.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /product_duplicates/1 or /product_duplicates/1.json
  def destroy
    @product_duplicate.destroy!

    respond_to do |format|
      format.html { redirect_to(product_duplicates_url, notice: 'Product duplicate was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product_duplicate
    @product_duplicate = ProductDuplicate.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_duplicate_params
    params.require(:product_duplicate).permit(:product_id, :canonical_product_id, :action, :certainty_percentage,
                                              :mapped_product_id, :levenshtein_distance, :similarity_score
    )
  end
end
