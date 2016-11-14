class Variant < ApplicationRecord
  belongs_to :variant_category
  has_many :dish_variants
  has_many :add_on_type_links, as: :addonable

  validates_presence_of :name, :display_name

  rails_admin do
    edit do
      configure :add_on_type_links do
        hide
      end
    end
  end
end
