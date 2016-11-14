class CreateCouponCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :coupon_categories do |t|
      t.string :name

      t.timestamps
    end
    add_index :coupon_categories, :name, unique: true
  end
end
