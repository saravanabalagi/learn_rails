class DishCategoriesController < ApplicationController
  # GET /dish_categories
  def index
    @dish_categories = DishCategory.all

    render json: @dish_categories
  end

  # GET /dish_categories/1
  def show
    @dish_category = DishCategory.find(params[:id])
    render json: @dish_category, include: :dishes
  end
end
