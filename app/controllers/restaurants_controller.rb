class RestaurantsController < ApplicationController

  # GET /restaurants/1
  def show
    @restaurants = Restaurant.find(params[:id])
    if @restaurants
      render status: :ok, json: @restaurants
    else
      render status: :not_found
    end
  end

end
