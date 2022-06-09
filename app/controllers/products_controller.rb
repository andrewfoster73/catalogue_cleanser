# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show; end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit; end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to(product_url(@product), notice: 'Product was successfully created.') }
        format.json { render(:show, status: :created, location: @product) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @product.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to(product_url(@product), notice: 'Product was successfully updated.') }
        format.json { render(:show, status: :ok, location: @product) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @product.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to(products_url, notice: 'Product was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:product_id, :status, :duplication_certainty, :canonical_certainty, :action,
                                    :collected_statistics_at, :spelling_mistakes, :catalogue_count, :buy_list_count,
                                    :priced_catalogue_count, :average_price, :maximum_price, :minimum_price,
                                    :standard_deviation, :variance, :inventory_barcodes_count,
                                    :inventory_derived_period_balances_count,
                                    :inventory_internal_requisition_lines_count, :inventory_stock_counts_count,
                                    :inventory_stock_levels_count, :inventory_transfer_items_count,
                                    :invoice_line_items_count, :point_of_sale_lines_count, :procurement_products_count,
                                    :product_supplier_preferences_count, :purchase_order_line_items_count,
                                    :rebates_profile_products_count, :receiving_document_line_items_count,
                                    :recipes_count, :requisition_line_items_count
    )
  end
end
