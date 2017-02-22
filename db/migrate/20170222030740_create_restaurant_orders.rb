class CreateRestaurantOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurant_orders do |t|
      t.belongs_to :order, foreign_key: true
      t.belongs_to :restaurant, foreign_key: true
      t.belongs_to :order_status, foreign_key: true
      t.belongs_to :coupon, foreign_key: true

      t.timestamps
    end
  end
end
