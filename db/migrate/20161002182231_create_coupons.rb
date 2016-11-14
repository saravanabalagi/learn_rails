class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :description
      t.decimal :amount
      t.decimal :percentage
      t.boolean :affects_vat
      t.boolean :affects_delivery
      t.decimal :max_amount
      t.decimal :min_cart_value
      t.integer :available
      t.datetime :expiry
      t.belongs_to :usable_by, polymorphic: true
      t.belongs_to :applied_on, polymorphic: true

      t.timestamps
    end
    add_index :coupons, :name, unique: true
  end
end
