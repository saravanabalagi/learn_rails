class PaymentMethodsController < ApplicationController

  # GET /payment_methods/1
  def show
    @payment_method = PaymentMethod.find(params[:id])
    render json: @payment_method
  end

end
