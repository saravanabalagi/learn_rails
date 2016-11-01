class CreateFeelCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :feel_categories do |t|
      t.string :name

      t.timestamps
    end
    add_index :feel_categories, :name, unique: true
  end
end
