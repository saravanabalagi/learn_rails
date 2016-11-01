class CreateVariants < ActiveRecord::Migration[5.0]
  def change
    create_table :variants do |t|
      t.string :name
      t.string :display_name

      t.timestamps
    end
    add_index :variants, :name, unique: true
  end
end
