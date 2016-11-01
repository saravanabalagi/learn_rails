class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :line1
      t.string :line2
      t.belongs_to :location, foreign_key: true
      t.string :mobile
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
