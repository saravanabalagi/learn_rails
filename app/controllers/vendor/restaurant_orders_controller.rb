class Vendor::RestaurantOrdersController < ApplicationController
  before_action :authenticate_user
  before_action :set_restaurant_orders

  # GET /vendor/restaurant_orders
  def index
    render json: @restaurant_orders.page(params[:page]),
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

  # PATCH/PUT /vendor/restaurant_orders/1/approve
  def approve
    @restaurant_order = @restaurant_orders.find(params[:id])
    @restaurant_order.order_status = OrderStatus.find_by(name: 'Accepted')
    if @restaurant_order.save
      BroadcastOrderJob.perform_later @restaurant_order.order
      render json: @restaurant_order,
                include: { order_items: { methods: :add_on_link_ids } },
                methods: [:total, :ordered_at, :payment_method_id]
    else
      render ststus: :unprocessable_entity, json: @restaurant_order.errors
    end
  end

  # PATCH/PUT /vendor/restaurant_orders/1/reject
  def reject
    @restaurant_order = @restaurant_orders.find(params[:id])
    @restaurant_order.order_status = OrderStatus.find_by(name: 'Rejected')
    if @restaurant_order.save
      BroadcastOrderJob.perform_later @restaurant_order.order
      render json: @restaurant_order,
                include: { order_items: { methods: :add_on_link_ids } },
                methods: [:total, :ordered_at, :payment_method_id]
    else
      render ststus: :unprocessable_entity, json: @restaurant_order.errors
    end
  end

  # PATCH/PUT /vendor/restaurant_orders/1/ready
  def ready
    @restaurant_order = @restaurant_orders.find(params[:id])
    @restaurant_order.order_status = OrderStatus.find_by(name: 'Ready')
    if @restaurant_order.save
      BroadcastOrderJob.perform_later @restaurant_order.order
      render json: @restaurant_order,
                include: { order_items: { methods: :add_on_link_ids } },
                methods: [:total, :ordered_at, :payment_method_id]
    else
      render ststus: :unprocessable_entity, json: @restaurant_order.errors
    end
  end

  # PATCH/PUT /vendor/restaurant_orders/1/collected
  def collected
    @restaurant_order = @restaurant_orders.find(params[:id])
    @restaurant_order.order_status = OrderStatus.find_by(name: 'Completed')
    if @restaurant_order.save
      BroadcastOrderJob.perform_later @restaurant_order.order
      render json: @restaurant_order,
                include: { order_items: { methods: :add_on_link_ids } },
                methods: [:total, :ordered_at, :payment_method_id]
    else
      render ststus: :unprocessable_entity, json: @restaurant_order.errors
    end
  end

  private

  def set_restaurant_orders
    if current_user.has_role?(:restaurant_admin, :any)
      restaurant_id = current_user.roles
                          .where(name: 'restaurant_admin', resource_type: 'Restaurant')[0]
                          .resource_id
      @restaurant_orders = RestaurantOrder.where(restaurant_id: restaurant_id)
                               .joins(:order_status)
                               .where.not('order_statuses.name': 'Initiated')
    else
      render status: :unauthorized
    end
  end

end
