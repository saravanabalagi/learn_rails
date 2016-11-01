class CreateAddOns < ActiveRecord::Migration[5.0]
  def change
    create_table :add_ons do |t|
      t.string :name
      t.belongs_to :add_on_type, foreign_key: true

      t.timestamps
    end
  end
end
