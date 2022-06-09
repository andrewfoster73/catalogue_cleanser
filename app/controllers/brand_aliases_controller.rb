# frozen_string_literal: true

class BrandAliasesController < ApplicationController
  before_action :set_brand_alias, only: %i[show edit update destroy]

  # GET /brand_aliases or /brand_aliases.json
  def index
    @brand_aliases = BrandAlias.all
  end

  # GET /brand_aliases/1 or /brand_aliases/1.json
  def show; end

  # GET /brand_aliases/new
  def new
    @brand_alias = BrandAlias.new
  end

  # GET /brand_aliases/1/edit
  def edit; end

  # POST /brand_aliases or /brand_aliases.json
  def create
    @brand_alias = BrandAlias.new(brand_alias_params)

    respond_to do |format|
      if @brand_alias.save
        format.html { redirect_to(brand_alias_url(@brand_alias), notice: 'Brand alias was successfully created.') }
        format.json { render(:show, status: :created, location: @brand_alias) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @brand_alias.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /brand_aliases/1 or /brand_aliases/1.json
  def update
    respond_to do |format|
      if @brand_alias.update(brand_alias_params)
        format.html { redirect_to(brand_alias_url(@brand_alias), notice: 'Brand alias was successfully updated.') }
        format.json { render(:show, status: :ok, location: @brand_alias) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @brand_alias.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /brand_aliases/1 or /brand_aliases/1.json
  def destroy
    @brand_alias.destroy!

    respond_to do |format|
      format.html { redirect_to(brand_aliases_url, notice: 'Brand alias was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_brand_alias
    @brand_alias = BrandAlias.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def brand_alias_params
    params.require(:brand_alias).permit(:brand_id, :alias, :confirmed, :count)
  end
end
