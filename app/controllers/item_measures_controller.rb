# frozen_string_literal: true

class ItemMeasuresController < ApplicationController
  before_action :set_item_measure, only: %i[show edit update destroy]

  # GET /item_measures or /item_measures.json
  def index
    @item_measures = ItemMeasure.all
  end

  # GET /item_measures/1 or /item_measures/1.json
  def show; end

  # GET /item_measures/new
  def new
    @item_measure = ItemMeasure.new
  end

  # GET /item_measures/1/edit
  def edit; end

  # POST /item_measures or /item_measures.json
  def create
    @item_measure = ItemMeasure.new(item_measure_params)

    respond_to do |format|
      if @item_measure.save
        format.html { redirect_to(item_measure_url(@item_measure), notice: 'Item measure was successfully created.') }
        format.json { render(:show, status: :created, location: @item_measure) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @item_measure.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /item_measures/1 or /item_measures/1.json
  def update
    respond_to do |format|
      if @item_measure.update(item_measure_params)
        format.html { redirect_to(item_measure_url(@item_measure), notice: 'Item measure was successfully updated.') }
        format.json { render(:show, status: :ok, location: @item_measure) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @item_measure.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /item_measures/1 or /item_measures/1.json
  def destroy
    @item_measure.destroy!

    respond_to do |format|
      format.html { redirect_to(item_measures_url, notice: 'Item measure was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item_measure
    @item_measure = ItemMeasure.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def item_measure_params
    params.require(:item_measure).permit(:name, :canonical)
  end
end
