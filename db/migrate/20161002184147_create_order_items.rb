class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.belongs_to :purchasable, polymorphic: true
      t.belongs_to :order, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
