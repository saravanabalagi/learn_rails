class DishesController < ApplicationController
  # GET /dishes/1
  def show
    @dish = Dish.find(params[:id])
    render json: @dish, include: { dish_variants:
                                       { include: { add_on_type_links:
                                                        { include: :add_on_links }} },
                                    restaurant: {only: [:id, :name, :logo]} },  methods: [:price]
  end
end
