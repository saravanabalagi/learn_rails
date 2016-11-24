class CitiesController < ApplicationController
  # GET /cities
  def index
    @cities = City.all

    render json: @cities
  end

  # GET /cities/1
  def show
    @city = City.find(params[:id])
    render json: @city, include: :locations
  end
end
