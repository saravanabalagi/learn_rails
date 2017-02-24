class Vendor::RestaurantOrdersController < ApplicationController
  before_action :authenticate_user
  before_action :set_restaurant_orders

  # GET /vendor/restaurant_orders
  def index
    render json: @restaurant_orders,
           include: { order_items: { methods: :add_on_link_ids } },
           methods: [:total, :ordered_at, :payment_method_id]
  end

  # GET /vendor/restaurant_orders/1
  def show
    @restaurant_order = @restaurant_orders.find(params[:id])
    render json: @restaurant_order,
           include: { order_items: { methods: :add_on_link_ids } },
           methods: [:total, :ordered_at, :payment_method_id]
  end

  private

  def set_restaurant_orders
    if current_user.has_role?(:restaurant_admin, :any)
      restaurant_id = current_user.roles
                          .where(name: 'restaurant_admin', resource_type: 'Restaurant')[0]
                          .resource_id
      @restaurant_orders = RestaurantOrder.where(restaurant_id: restaurant_id)
    else
      render status: :unauthorized
    end
  end

end
