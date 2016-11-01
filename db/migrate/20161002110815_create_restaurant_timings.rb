class CreateRestaurantTimings < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurant_timings do |t|
      t.time :opening_time
      t.time :closing_time
      t.belongs_to :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
