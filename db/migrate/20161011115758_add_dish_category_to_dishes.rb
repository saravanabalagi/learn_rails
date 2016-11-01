class AddDishCategoryToDishes < ActiveRecord::Migration[5.0]
  def change
    add_reference :dishes, :dish_category, foreign_key: true
  end
end
