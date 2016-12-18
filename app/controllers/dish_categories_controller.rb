class DishCategoriesController < ApplicationController
  before_action :set_packaging_centre

  # GET /dish_categories
  def index
    @dish_categories = @packaging_centre.dish_categories
    render json: @dish_categories
  end

  # GET /dish_categories/1/dishes
  def dishes
    @dishes = @packaging_centre.dishes
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
  def set_packaging_centre
    @packaging_centre = Location.find(request.headers['Location']).packaging_centre
  end

end
