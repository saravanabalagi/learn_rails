class Brand < ApplicationRecord
  has_many :coupons, as: :couponable

  validates_presence_of :name
  validates_uniqueness_of :name, :business_name
end
