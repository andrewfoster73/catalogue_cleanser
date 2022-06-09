# frozen_string_literal: true

class AbbreviationsController < ApplicationController
  before_action :set_abbreviation, only: %i[show edit update destroy]

  # GET /abbreviations or /abbreviations.json
  def index
    @abbreviations = Abbreviation.all
  end

  # GET /abbreviations/1 or /abbreviations/1.json
  def show; end

  # GET /abbreviations/new
  def new
    @abbreviation = Abbreviation.new
  end

  # GET /abbreviations/1/edit
  def edit; end

  # POST /abbreviations or /abbreviations.json
  def create
    @abbreviation = Abbreviation.new(abbreviation_params)

    respond_to do |format|
      if @abbreviation.save
        format.html { redirect_to(abbreviation_url(@abbreviation), notice: 'abbreviation was successfully created.') }
        format.json { render(:show, status: :created, location: @abbreviation) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @abbreviation.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /abbreviations/1 or /abbreviations/1.json
  def update
    respond_to do |format|
      if @abbreviation.update(abbreviation_params)
        format.html { redirect_to(abbreviation_url(@abbreviation), notice: 'abbreviation was successfully updated.') }
        format.json { render(:show, status: :ok, location: @abbreviation) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @abbreviation.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /abbreviations/1 or /abbreviations/1.json
  def destroy
    @abbreviation.destroy!

    respond_to do |format|
      format.html { redirect_to(abbreviations_url, notice: 'abbreviation was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_abbreviation
    @abbreviation = Abbreviation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def abbreviation_params
    params.require(:abbreviation).permit(:dictionary_entry_id, :letters)
  end
end
