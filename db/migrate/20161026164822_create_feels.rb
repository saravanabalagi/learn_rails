class CreateFeels < ActiveRecord::Migration[5.0]
  def change
    create_table :feels do |t|
      t.string :name
      t.belongs_to :feel_category, foreign_key: true

      t.timestamps
    end
    add_index :feels, :name, unique: true
  end
end
