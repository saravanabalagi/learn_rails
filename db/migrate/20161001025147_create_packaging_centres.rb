class CreatePackagingCentres < ActiveRecord::Migration[5.0]
  def change
    create_table :packaging_centres do |t|
      t.string :name

      t.timestamps
    end
    add_index :packaging_centres, :name, unique: true
  end
end
