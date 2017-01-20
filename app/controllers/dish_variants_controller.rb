class DishVariantsController < ApplicationController

  # GET /dish_variants/1
  def show
    @dish_variant = DishVariant.find(params[:id])
    if @dish_variant
      render status: :ok, json: @dish_variant
    else
      render status: :not_found
    end
  end

end
