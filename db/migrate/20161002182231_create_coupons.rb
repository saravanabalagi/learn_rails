class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :description
      t.integer :available
      t.integer :used
      t.belongs_to :user, foreign_key: true
      t.boolean :affects_surcharges
      t.decimal :amount
      t.decimal :min_cart_value
      t.decimal :percentage
      t.decimal :max_amount
      t.datetime :expiry
      t.belongs_to :couponable, polymorphic: true

      t.timestamps
    end
    add_index :coupons, :name, unique: true
  end
end
