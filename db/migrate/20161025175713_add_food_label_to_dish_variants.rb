class AddFoodLabelToDishVariants < ActiveRecord::Migration[5.0]
  def change
    add_reference :dish_variants, :food_label, foreign_key: true
  end
end
