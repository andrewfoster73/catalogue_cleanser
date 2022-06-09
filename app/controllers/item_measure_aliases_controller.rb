# frozen_string_literal: true

class ItemMeasureAliasesController < ApplicationController
  before_action :set_item_measure_alias, only: %i[show edit update destroy]

  # GET /item_measure_aliases or /item_measure_aliases.json
  def index
    @item_measure_aliases = ItemMeasureAlias.all
  end

  # GET /item_measure_aliases/1 or /item_measure_aliases/1.json
  def show; end

  # GET /item_measure_aliases/new
  def new
    @item_measure_alias = ItemMeasureAlias.new
  end

  # GET /item_measure_aliases/1/edit
  def edit; end

  # POST /item_measure_aliases or /item_measure_aliases.json
  def create
    @item_measure_alias = ItemMeasureAlias.new(item_measure_alias_params)

    respond_to do |format|
      if @item_measure_alias.save
        format.html do
          redirect_to(item_measure_alias_url(@item_measure_alias),
                      notice: 'Item measure alias was successfully created.'
                     )
        end
        format.json { render(:show, status: :created, location: @item_measure_alias) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @item_measure_alias.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /item_measure_aliases/1 or /item_measure_aliases/1.json
  def update
    respond_to do |format|
      if @item_measure_alias.update(item_measure_alias_params)
        format.html do
          redirect_to(item_measure_alias_url(@item_measure_alias),
                      notice: 'Item measure alias was successfully updated.'
                     )
        end
        format.json { render(:show, status: :ok, location: @item_measure_alias) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @item_measure_alias.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /item_measure_aliases/1 or /item_measure_aliases/1.json
  def destroy
    @item_measure_alias.destroy!

    respond_to do |format|
      format.html { redirect_to(item_measure_aliases_url, notice: 'Item measure alias was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item_measure_alias
    @item_measure_alias = ItemMeasureAlias.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def item_measure_alias_params
    params.require(:item_measure_alias).permit(:item_measure_id, :alias, :confirmed)
  end
end
