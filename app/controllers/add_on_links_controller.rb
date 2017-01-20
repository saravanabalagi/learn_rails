class AddOnLinksController < ApplicationController

  # GET /add_on_links/1
  def show
    @add_on_link = AddOnLink.find(params[:id])
    if @add_on_link
      render status: :ok, json: @add_on_link
    else
      render status: :not_found
    end
  end

end
