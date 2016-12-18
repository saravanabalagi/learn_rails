class CitiesController < ApplicationController
  # GET /cities
  def index
    @cities = City.all

    render json: @cities
  end

  # GET /cities/1/locations
  def locations
    @locations = City.find(params[:id]).locations
    render json: @locations
  end
end
