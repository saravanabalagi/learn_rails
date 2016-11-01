class CreateAddOnTypeLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :add_on_type_links do |t|
      t.belongs_to :add_on_type, foreign_key: true
      t.belongs_to :addonable, polymorphic: true
      t.integer :min, default: 0
      t.integer :max

      t.timestamps
    end
  end
end
