class CreateDishVariants < ActiveRecord::Migration[5.0]
  def change
    create_table :dish_variants do |t|
      t.string :name
      t.decimal :price
      t.string :image
      t.string :icon
      t.belongs_to :dish, foreign_key: true

      t.timestamps
    end
  end
end
