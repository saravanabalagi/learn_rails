class BroadcastOrderJob < ApplicationJob
  queue_as :default

  def perform(order)
    ActionCable.server.broadcast 'order_user_'+order.user_id.to_s,
                                 order: order, include: { restaurant_orders: { include: {order_items: { methods: :add_on_link_ids}}} }
  end
end
