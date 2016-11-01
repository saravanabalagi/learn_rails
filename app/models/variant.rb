class Variant < ApplicationRecord
  has_many :dish_variants
  has_many :add_on_type_links, as: :addonable

  validates_presence_of :name, :display_name
end
