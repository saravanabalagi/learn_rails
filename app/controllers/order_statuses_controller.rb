class OrderStatusesController < ApplicationController

  # GET /order_statuses/1
  def show
    @order_status = OrderStatus.find(params[:id])
    render json: @order_status
  end

end
