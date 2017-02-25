class BroadcastRestaurantOrderJob < ApplicationJob
  queue_as :default

  def perform(restaurant_order)
    ActionCable.server.broadcast 'order_restaurant_'+restaurant_order.restaurant_id.to_s,
                                 restaurant_order: restaurant_order, include: { restaurant_orders: { include: {order_items: { methods: :add_on_link_ids}}} }
  end
end
