class CouponCategory < ApplicationRecord
  has_many :coupons

  validates_presence_of :name
  validates_uniqueness_of :name
end
