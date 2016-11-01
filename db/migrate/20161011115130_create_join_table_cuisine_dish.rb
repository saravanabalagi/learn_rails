class CreateJoinTableCuisineDish < ActiveRecord::Migration[5.0]
  def change
    create_join_table :cuisines, :dishes do |t|
      t.index [:cuisine_id, :dish_id]
      t.index [:dish_id, :cuisine_id]
    end
  end
end
