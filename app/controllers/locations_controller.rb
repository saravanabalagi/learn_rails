class LocationsController < ApplicationController

  # GET /locations/1
  def show
    @location = Location.find(params[:id])
    render json: @location, status: :ok
  end

end
