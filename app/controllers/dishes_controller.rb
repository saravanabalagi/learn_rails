class DishesController < ApplicationController
  before_action :set_dishes

  # GET /dishes/1
  def show
    @dish = @dishes.find(params[:id])
    if @dish.present?
      render json: @dish, methods: :dish_variant_ids
    else
      render status: :not_found
    end
  end

  private
  def set_dishes
    @dishes = Location.find(request.headers['Location']).dishes
  end

end
