class AddOrderedToOrderItems < ActiveRecord::Migration[5.0]
  def change
    add_column :order_items, :ordered, :string, null: false, default: '{}'
  end
end