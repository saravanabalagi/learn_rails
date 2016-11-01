class CreatePhoneTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :phone_types do |t|
      t.string :name

      t.timestamps
    end
    add_index :phone_types, :name, unique: true
  end
end
