class OrdersController < ApplicationController
  before_action :authenticate_user
  before_action :set_orders
  before_action :set_cart

  # GET /orders
  def index
    render json: @orders, include: :order_status, only: [:id, :total, :ordered_at]
  end

  # GET /orders/1
  def show
    @order = @orders.find(params[:id])
    render json: @order, include: [:order_status, :payment_method,
                                   address: { include: { location: { include: :city} }, only: [:name, :line1, :line2, :mobile]}]
  end

  # GET /cart
  def cart
    render json: @cart
  end

  # POST /cart/purchase/cod
  def purchase_cod
    @cart.purchase_by_cod
    render json: @cart
  end

  # GET /cart/set_address
  def set_address
    params.require(:address_id)
    @cart.address_id = params[:address_id]
    if @cart.save
      render json: @cart, only: [:delivery, :total, :sub_total, :vat, :id]
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # POST /cart
  def order_items
    @cart.order_items.destroy_all

    order_params
    order_items = {}
    order_items[:succeeded] = []
    order_items[:errors] = []

    @order_params.key?(:dish_variants) && @order_params[:dish_variants].each do |order_item_params|
      @order_item = OrderItem.new(order_item_params)
      @order_item.order = @cart
      if @order_item.save
        order_items[:succeeded].push @order_item
      else
        order_items[:errors].push @order_item.errors
      end
    end

    @order_params.key?(:combos) && @order_params[:combos].each do |order_item_params|
      @order_item = OrderItem.new(order_item_params)
      @order_item.order = @cart
      if @order_item.save
        order_items[:succeeded].push @order_item
      else
        order_items[:errors].push @order_item.errors
      end
    end

    render json: order_items, status: order_items[:errors].length == 0 ? :created : :unprocessable_entity

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
    @order_params = params.permit(dish_variants: [:id, :quantity, :ordered])
    if @order_params.key?(:dish_variants) && @order_params[:dish_variants].kind_of?(Array)
      @order_params[:dish_variants].each do |dish_variant|
        dish_variant[:purchasable_type] = 'DishVariant'
        dish_variant[:purchasable_id] = dish_variant[:id]
        dish_variant.delete(:id)
      end
    end
    if @order_params.key?(:combos) && @order_params[:combos].kind_of?(Array)
      @order_params[:combos].each do |combo|
        combo[:purchasable_type] = 'Combo'
        combo[:purchasable_id] = combo[:id]
        combo.delete(:id)
      end
    end
    @order_params.permit(dish_variants: [:purchasable_id, :purchasable_type, :quantity, :ordered])
  end
end
