# frozen_string_literal: true

class ItemPackAliasesController < ApplicationController
  before_action :set_item_pack_alias, only: %i[show edit update destroy]

  # GET /item_pack_aliases or /item_pack_aliases.json
  def index
    @item_pack_aliases = ItemPackAlias.all
  end

  # GET /item_pack_aliases/1 or /item_pack_aliases/1.json
  def show; end

  # GET /item_pack_aliases/new
  def new
    @item_pack_alias = ItemPackAlias.new
  end

  # GET /item_pack_aliases/1/edit
  def edit; end

  # POST /item_pack_aliases or /item_pack_aliases.json
  def create
    @item_pack_alias = ItemPackAlias.new(item_pack_alias_params)

    respond_to do |format|
      if @item_pack_alias.save
        format.html do
          redirect_to(item_pack_alias_url(@item_pack_alias), notice: 'Item pack alias was successfully created.')
        end
        format.json { render(:show, status: :created, location: @item_pack_alias) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @item_pack_alias.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /item_pack_aliases/1 or /item_pack_aliases/1.json
  def update
    respond_to do |format|
      if @item_pack_alias.update(item_pack_alias_params)
        format.html do
          redirect_to(item_pack_alias_url(@item_pack_alias), notice: 'Item pack alias was successfully updated.')
        end
        format.json { render(:show, status: :ok, location: @item_pack_alias) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @item_pack_alias.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /item_pack_aliases/1 or /item_pack_aliases/1.json
  def destroy
    @item_pack_alias.destroy!

    respond_to do |format|
      format.html { redirect_to(item_pack_aliases_url, notice: 'Item pack alias was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item_pack_alias
    @item_pack_alias = ItemPackAlias.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def item_pack_alias_params
    params.require(:item_pack_alias).permit(:item_pack_id, :alias, :confirmed)
  end
end
