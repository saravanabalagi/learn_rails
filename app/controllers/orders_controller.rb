class OrdersController < ApplicationController
  before_action :authenticate_user
  before_action :set_orders

  # GET /orders
  def index
    render json: @orders
  end

  # GET /orders/1
  def show
    @order = @orders.find(params[:id])
    render json: @order
  end

  # GET /cart
  def cart
    @order = @orders
                 .joins(:order_status)
                 .find_by('order_statuses.name': 'Initiated')
    render json: @order
  end

  private
  def set_orders
    @orders = current_user.orders
                  .joins(:order_status)
                  .where.not('order_statuses.name': 'Initiated')
  end
end
