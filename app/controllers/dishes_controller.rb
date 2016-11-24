class DishesController < ApplicationController
  # GET /dishes
  def index
    @dishes = Dish.all

    render json: @dishes
  end

  # GET /dishes/1
  def show
    @dish = Dish.find(params[:id])
    render json: @dish
  end
end
