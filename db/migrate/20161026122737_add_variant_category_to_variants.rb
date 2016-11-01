class AddVariantCategoryToVariants < ActiveRecord::Migration[5.0]
  def change
    add_reference :variants, :variant_category, foreign_key: true
  end
end
