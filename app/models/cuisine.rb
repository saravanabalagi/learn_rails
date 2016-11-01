class Cuisine < ApplicationRecord
  has_and_belongs_to_many :dishes
  has_and_belongs_to_many :restaurants

  validates_uniqueness_of :name
  validates_presence_of :name
end
