class OrdersController < ApplicationController
  before_action :authenticate_user
  before_action :set_orders
  before_action :set_cart

  # GET /orders
  def index
    render json: @orders, include: { restaurant_orders: { include: {order_items: { methods: :add_on_link_ids}}} }
  end

  # GET /orders/1
  def show
    @order = @orders.find(params[:id])
    render json: @order, include: { restaurant_orders: { include: {order_items: { methods: :add_on_link_ids}}} }
  end

  # GET /cart
  def cart
    render json: @cart, include: { restaurant_orders: { include: {order_items: { methods: :add_on_link_ids}}} }
  end

  # POST /cart/purchase/cod
  def purchase_cod
    @cart.purchase_by_cod
    @cart.restaurant_order.each do |restaurant_order|
      BroadcastRestaurantOrderJob.perform_later restaurant_order
    end
    render json: @cart, include: { restaurant_orders: { include: {order_items: { methods: :add_on_link_ids}}} }
  end

  # POST /cart
  def order_items
    @cart.restaurant_orders.destroy_all

    cart = {}
    cart[:errors] = []

    order_params[:restaurant_orders].each do |restaurant_order|
      @restaurant_order = RestaurantOrder.new
      @restaurant_order.order = @cart
      @restaurant_order.restaurant = Restaurant.find(restaurant_order[:restaurant_id])
      @restaurant_order.order_status = OrderStatus.find_by_name('Initiated')
      if @restaurant_order.save
        restaurant_order[:order_items].each do |order_item_params|
          @order_item = OrderItem.new
          @order_item.dish_variant = DishVariant.find(order_item_params[:dish_variant_id])
          @order_item.note = order_item_params[:note]
          @order_item.quantity = order_item_params[:quantity]
          order_item_params[:add_on_link_ids].each { |add_on_link_id| @order_item.add_on_links.push(AddOnLink.find(add_on_link_id)) }
          @order_item.restaurant_order = @restaurant_order
          unless @order_item.save
            cart[:errors].push @order_item.errors
          end
        end
      else cart[:errors].push @restaurant_order.errors
      end
    end

    cart[:cart] = @cart.restaurant_orders
    cart[:values] = @cart.slice(:delivery, :total, :sub_total, :vat, :id)
    render json: cart, status: cart[:errors].length == 0 ? :created : :unprocessable_entity

  end

  private
  def set_orders
    @orders = current_user.orders
                  .joins(:order_status)
                  .where.not('order_statuses.name': 'Initiated')
  end

  def set_cart
    @cart = current_user.orders
                 .joins(:order_status)
                 .find_by('order_statuses.name': 'Initiated')
    if @cart.nil?
      @cart = Order.new
      @cart.user = current_user
    end
  end

  def order_params
    params.permit(restaurant_orders: [:restaurant_id, order_items: [:dish_variant_id, :quantity, :note, add_on_link_ids: []]])
  end
end
