class CreateAddOnLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :add_on_links do |t|
      t.belongs_to :add_on, foreign_key: true
      t.belongs_to :add_on_type_link, foreign_key: true
      t.decimal :price
      t.boolean :selected

      t.timestamps
    end

    add_index :add_on_links, [:add_on_id, :add_on_type_link_id], unique: true
  end
end
