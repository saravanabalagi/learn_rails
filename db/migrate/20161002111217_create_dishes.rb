class CreateDishes < ActiveRecord::Migration[5.0]
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :image
      t.belongs_to :restaurant, foreign_key: true
      t.boolean :available

      t.timestamps
    end
  end
end
