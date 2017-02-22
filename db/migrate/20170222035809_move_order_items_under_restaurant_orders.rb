class MoveOrderItemsUnderRestaurantOrders < ActiveRecord::Migration[5.0]
  def change
    remove_reference :order_items, :order, foreign_key: true
    add_reference :order_items, :restaurant_order, foreign_key: true
  end
end
