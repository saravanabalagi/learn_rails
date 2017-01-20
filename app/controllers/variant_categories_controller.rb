class VariantCategoriesController < ApplicationController

  # GET /variant_categories/1
  def show
    @variant_categories = VariantCategory.find(params[:id])
    if @variant_categories
      render status: :ok, json: @variant_categories
    else
      render status: :not_found
    end
  end

end
