class CreateFeelLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :feel_links do |t|
      t.belongs_to :feelable, polymorphic: true
      t.belongs_to :feel, foreign_key: true
      t.integer :scale, default: 0

      t.timestamps
    end
  end
end
