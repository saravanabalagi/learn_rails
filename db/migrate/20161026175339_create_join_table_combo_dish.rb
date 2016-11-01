class CreateJoinTableComboDish < ActiveRecord::Migration[5.0]
  def change
    create_join_table :combos, :dishes do |t|
      t.index [:combo_id, :dish_id]
      t.index [:dish_id, :combo_id]
    end
  end
end
