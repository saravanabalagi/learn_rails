class FoodLabel < ApplicationRecord
  has_many :dish_variants

  validates_presence_of :name
  validates_uniqueness_of :name
end
