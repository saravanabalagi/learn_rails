class AddOnsController < ApplicationController

  # GET /add_ons/1
  def show
    @add_on = AddOn.find(params[:id])
    if @add_on
      render status: :ok, json: @add_on
    else
      render status: :not_found
    end
  end

end
