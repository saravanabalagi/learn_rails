class CreateRestaurantPhones < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurant_phones do |t|
      t.belongs_to :phone_type, foreign_key: true
      t.string :value
      t.belongs_to :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
