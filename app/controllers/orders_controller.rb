class OrdersController < ApplicationController
  before_action :authenticate_user
  before_action :set_orders
  before_action :set_cart

  # GET /orders
  def index
    render json: @orders, include: [:order_status,:payment_method,:order_items]
  end

  # GET /orders/1
  def show
    @order = @orders.find(params[:id])
    render json: @order, include: [:order_status, :payment_method,:order_items]
  end

  # GET /cart
  def cart
    render json: @cart, include: [:order_status, :payment_method,:order_items]
  end

  # POST /cart/purchase/cod
  def purchase_cod
    @cart.purchase_by_cod
    render json: @cart
  end

  # POST /cart
  def order_items
    @cart.order_items.destroy_all

    order_params
    cart = {}
    cart[:errors] = []

    order_params[:order_items].each do |order_item_params|
      @order_item = OrderItem.new
      @order_item.dish_variant = DishVariant.find(order_item_params.dish_variant_id)
      @order_item.note = order_item_params[:note]
      @order_item.quantity = order_item_params[:quantity]
      order_item_params[:add_on_link_ids].each { |add_on_link_id| @order_item.add_on_links.push(AddOnLink.find(add_on_link_id)) }
      @order_item.order = @cart
      unless @order_item.save
        cart[:errors].push @order_item.errors
      end
    end

    cart[:cart] = @cart.order_items
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
    params.fetch(:order_items, {}).permit(:dish_variant_id, :quantity, :note, :add_on_link_ids)
  end
end
