class CreateAddOnTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :add_on_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
