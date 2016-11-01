class Restaurant < ApplicationRecord
  belongs_to :location
  belongs_to :brand
  has_many :dishes
  has_many :restaurant_timings
  has_many :restaurant_phones
  has_and_belongs_to_many :cuisines

  validates_presence_of :location
  validates_presence_of :name, :address_line1, :address_line2

end
