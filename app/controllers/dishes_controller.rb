class DishesController < ApplicationController
  before_action :set_dishes

  # GET /dishes/1
  def show
    @dish = @dishes.find(params[:id])
    if @dish.present?
      render json: @dish, include: { dish_variants:
                                       { include: { add_on_type_links:
                                                        { include: :add_on_links }} },
                                    restaurant: {only: [:id, :name, :logo]} },  methods: [:price]
    else
      render status: :not_found
    end
  end

  private
  def set_dishes
    @dishes = Location.find(request.headers['Location']).packaging_centre.dishes
  end

end
