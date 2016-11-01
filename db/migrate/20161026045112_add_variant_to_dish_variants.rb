class AddVariantToDishVariants < ActiveRecord::Migration[5.0]
  def change
    remove_column :dish_variants, :name, :string
    add_reference :dish_variants, :variant, foreign_key: true
  end
end
