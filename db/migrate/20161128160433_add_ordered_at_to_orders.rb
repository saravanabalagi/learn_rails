class AddOrderedAtToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :ordered_at, :datetime
    add_index :orders, :ordered_at
  end
end
