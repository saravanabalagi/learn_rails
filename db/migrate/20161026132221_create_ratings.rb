class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :dish, foreign_key: true
      t.integer :stars, default: 5

      t.timestamps
    end
    add_index :ratings, [:user_id, :dish_id], unique: true
  end
end
