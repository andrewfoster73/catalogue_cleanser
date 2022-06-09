# frozen_string_literal: true

class ItemSellPacksController < ApplicationController
  before_action :set_item_sell_pack, only: %i[show edit update destroy]

  # GET /item_sell_packs or /item_sell_packs.json
  def index
    @item_sell_packs = ItemSellPack.all
  end

  # GET /item_sell_packs/1 or /item_sell_packs/1.json
  def show; end

  # GET /item_sell_packs/new
  def new
    @item_sell_pack = ItemSellPack.new
  end

  # GET /item_sell_packs/1/edit
  def edit; end

  # POST /item_sell_packs or /item_sell_packs.json
  def create
    @item_sell_pack = ItemSellPack.new(item_sell_pack_params)

    respond_to do |format|
      if @item_sell_pack.save
        format.html do
          redirect_to(item_sell_pack_url(@item_sell_pack), notice: 'Item sell pack was successfully created.')
        end
        format.json { render(:show, status: :created, location: @item_sell_pack) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @item_sell_pack.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /item_sell_packs/1 or /item_sell_packs/1.json
  def update
    respond_to do |format|
      if @item_sell_pack.update(item_sell_pack_params)
        format.html do
          redirect_to(item_sell_pack_url(@item_sell_pack), notice: 'Item sell pack was successfully updated.')
        end
        format.json { render(:show, status: :ok, location: @item_sell_pack) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @item_sell_pack.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /item_sell_packs/1 or /item_sell_packs/1.json
  def destroy
    @item_sell_pack.destroy!

    respond_to do |format|
      format.html { redirect_to(item_sell_packs_url, notice: 'Item sell pack was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item_sell_pack
    @item_sell_pack = ItemSellPack.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def item_sell_pack_params
    params.require(:item_sell_pack).permit(:name, :canonical)
  end
end
