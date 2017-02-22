class RestaurantOrder < ApplicationRecord
  belongs_to :order
  belongs_to :restaurant
  belongs_to :order_status
  belongs_to :coupon

  has_many :order_items, :dependent => :destroy
  accepts_nested_attributes_for :order_items, allow_destroy: true

end
