class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.belongs_to :packaging_centre, foreign_key: true
      t.belongs_to :city, foreign_key: true

      t.timestamps
    end
    add_index :locations, :name, unique: true
  end
end
