class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :logo
      t.string :email
      t.string :address_line1
      t.string :address_line2
      t.belongs_to :location, foreign_key: true
      t.belongs_to :brand, foreign_key: true

      t.timestamps
    end
  end
end
