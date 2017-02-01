class DishCategoriesController < ApplicationController
  before_action :set_location

  # GET /dish_categories
  def index
    @dish_categories = @location.dish_categories
    render json: @dish_categories, methods: :dish_ids
  end

  # GET /dish_categories/1
  def show
    @dish_category = @location.dish_categories.find(params[:id])
    render json: @dish_category, methods: :dish_ids
  end

  # GET /dish_categories/1/dishes
  def dishes
    @dishes = @location.dishes
                      .joins(:dish_category)
                      .where('dish_categories.id':params[:id])
    render json: @dishes
  end

  private
  def set_location
    @location = Location.find(request.headers['Location'])
  end

end
