# frozen_string_literal: true

class ItemPacksController < ApplicationController
  before_action :set_item_pack, only: %i[show edit update destroy]

  # GET /item_packs or /item_packs.json
  def index
    @item_packs = ItemPack.all
  end

  # GET /item_packs/1 or /item_packs/1.json
  def show; end

  # GET /item_packs/new
  def new
    @item_pack = ItemPack.new
  end

  # GET /item_packs/1/edit
  def edit; end

  # POST /item_packs or /item_packs.json
  def create
    @item_pack = ItemPack.new(item_pack_params)

    respond_to do |format|
      if @item_pack.save
        format.html { redirect_to(item_pack_url(@item_pack), notice: 'Item pack was successfully created.') }
        format.json { render(:show, status: :created, location: @item_pack) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @item_pack.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /item_packs/1 or /item_packs/1.json
  def update
    respond_to do |format|
      if @item_pack.update(item_pack_params)
        format.html { redirect_to(item_pack_url(@item_pack), notice: 'Item pack was successfully updated.') }
        format.json { render(:show, status: :ok, location: @item_pack) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @item_pack.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /item_packs/1 or /item_packs/1.json
  def destroy
    @item_pack.destroy!

    respond_to do |format|
      format.html { redirect_to(item_packs_url, notice: 'Item pack was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item_pack
    @item_pack = ItemPack.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def item_pack_params
    params.require(:item_pack).permit(:name, :canonical)
  end
end
