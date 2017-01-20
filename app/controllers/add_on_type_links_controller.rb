class AddOnTypeLinksController < ApplicationController

  # GET /add_on_type_links/1
  def show
    @add_on_type_link = AddOnTypeLink.find(params[:id])
    if @add_on_type_link
      render status: :ok, json: @add_on_type_link
    else
      render status: :not_found
    end
  end

end
