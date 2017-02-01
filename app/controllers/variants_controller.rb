class VariantsController < ApplicationController

  # GET /variants/1
  def show
    @variant = Variant.find(params[:id])
    if @variant
      render status: :ok, json: @variant, methods: :add_on_type_link_ids
    else
      render status: :not_found
    end
  end

end
