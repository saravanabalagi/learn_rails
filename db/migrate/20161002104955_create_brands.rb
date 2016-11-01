class CreateBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :brands do |t|
      t.string :name
      t.string :business_name
      t.string :logo

      t.timestamps
    end
    add_index :brands, :name, unique: true
    add_index :brands, :business_name, unique: true
  end
end
