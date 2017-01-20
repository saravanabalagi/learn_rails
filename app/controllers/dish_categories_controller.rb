class DishCategoriesController < ApplicationController
  before_action :set_location

  # GET /dish_categories
  def index
    @dish_categories = @location.dish_categories
    render json: @dish_categories
  end

  # GET /dish_categories/1/dishes
  def dishes
    @dishes = @location.dishes
                      .joins(:dish_category)
                      .where('dish_categories.id':params[:id])
    if @dishes.length > 0
      render json: @dishes, include: { restaurant:
                                              {only: [:id, :name, :logo]}},
                              methods: [:price],
                              only: [:id, :name, :image, :available]
    else
      render status: :not_found
    end
  end

  private
  def set_location
    @location = Location.find(request.headers['Location'])
  end

end
