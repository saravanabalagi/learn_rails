class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :order_status, foreign_key: true
      t.belongs_to :address, foreign_key: true
      t.belongs_to :coupon, foreign_key: true
      t.decimal :sub_total
      t.decimal :delivery
      t.decimal :vat
      t.decimal :total
      t.belongs_to :payment_method, foreign_key: true

      t.timestamps
    end
  end
end
