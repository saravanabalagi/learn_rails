class CreatePaymentMethods < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_methods do |t|
      t.string :name

      t.timestamps
    end
    add_index :payment_methods, :name, unique: true
  end
end
