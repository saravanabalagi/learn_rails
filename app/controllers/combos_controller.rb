class CombosController < ApplicationController
  # GET /combos
  def index
    @combos = Combo.all

    render json: @combos
  end

  # GET /combos/1
  def show
    @combo = Combo.find(params[:id])
    render json: @combo
  end
end
