class CreateOrderStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :order_statuses do |t|
      t.string :name

      t.timestamps
    end
    add_index :order_statuses, :name, unique: true
  end
end
