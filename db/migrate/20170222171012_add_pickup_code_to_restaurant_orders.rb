class AddPickupCodeToRestaurantOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurant_orders, :pickup_code, :string
  end
end
