class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.belongs_to :dish_variant, foreign_key: true
      t.belongs_to :order, foreign_key: true
      t.integer :quantity
      t.text :note

      t.timestamps
    end
  end
end
