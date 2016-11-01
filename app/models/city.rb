class City < ApplicationRecord
  has_many :locations
  has_many :coupons, as: :couponable

  validates_presence_of :name
  validates_uniqueness_of :name
end
