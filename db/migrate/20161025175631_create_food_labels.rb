class CreateFoodLabels < ActiveRecord::Migration[5.0]
  def change
    create_table :food_labels do |t|
      t.string :name

      t.timestamps
    end
    add_index :food_labels, :name, unique: true
  end
end
