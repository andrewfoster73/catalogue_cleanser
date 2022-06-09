# frozen_string_literal: true

class ItemSellPackAliasesController < ApplicationController
  before_action :set_item_sell_pack_alias, only: %i[show edit update destroy]

  # GET /item_sell_pack_aliases or /item_sell_pack_aliases.json
  def index
    @item_sell_pack_aliases = ItemSellPackAlias.all
  end

  # GET /item_sell_pack_aliases/1 or /item_sell_pack_aliases/1.json
  def show; end

  # GET /item_sell_pack_aliases/new
  def new
    @item_sell_pack_alias = ItemSellPackAlias.new
  end

  # GET /item_sell_pack_aliases/1/edit
  def edit; end

  # POST /item_sell_pack_aliases or /item_sell_pack_aliases.json
  def create
    @item_sell_pack_alias = ItemSellPackAlias.new(item_sell_pack_alias_params)

    respond_to do |format|
      if @item_sell_pack_alias.save
        format.html do
          redirect_to(item_sell_pack_alias_url(@item_sell_pack_alias),
                      notice: 'Item sell pack alias was successfully created.'
                     )
        end
        format.json { render(:show, status: :created, location: @item_sell_pack_alias) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @item_sell_pack_alias.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /item_sell_pack_aliases/1 or /item_sell_pack_aliases/1.json
  def update
    respond_to do |format|
      if @item_sell_pack_alias.update(item_sell_pack_alias_params)
        format.html do
          redirect_to(item_sell_pack_alias_url(@item_sell_pack_alias),
                      notice: 'Item sell pack alias was successfully updated.'
                     )
        end
        format.json { render(:show, status: :ok, location: @item_sell_pack_alias) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @item_sell_pack_alias.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /item_sell_pack_aliases/1 or /item_sell_pack_aliases/1.json
  def destroy
    @item_sell_pack_alias.destroy!

    respond_to do |format|
      format.html do
        redirect_to(item_sell_pack_aliases_url, notice: 'Item sell pack alias was successfully destroyed.')
      end
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item_sell_pack_alias
    @item_sell_pack_alias = ItemSellPackAlias.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def item_sell_pack_alias_params
    params.require(:item_sell_pack_alias).permit(:item_sell_pack_id, :alias, :confirmed)
  end
end
