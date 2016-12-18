class LocationsController < ApplicationController
  # GET /locations/1/siblings
  def siblings
    @locations = Location.find(params[:id]).packaging_centre.locations
    render json: @locations
  end
end
