class AddOnTypesController < ApplicationController

  # GET /add_on_types/1
  def show
    @add_on_type = AddOnType.find(params[:id])
    if @add_on_type
      render status: :ok, json: @add_on_type
    else
      render status: :not_found
    end
  end

end
