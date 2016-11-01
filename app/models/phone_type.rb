class PhoneType < ApplicationRecord
  has_many :restaurant_phones

  validates_presence_of :name
  validates_uniqueness_of :name
end
