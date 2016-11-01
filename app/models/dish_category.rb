class DishCategory < ApplicationRecord
  has_many :dishes

  validates_uniqueness_of :name
  validates_presence_of :name
end
