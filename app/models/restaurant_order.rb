class RestaurantOrder < ApplicationRecord
  belongs_to :order
  belongs_to :restaurant
  belongs_to :order_status
  belongs_to :coupon

  has_many :order_items, :dependent => :destroy
  accepts_nested_attributes_for :order_items, allow_destroy: true

  before_create :set_pickup_code

  private
  def set_pickup_code
    o = [('0'..'9'), ('A'..'Z')].map(&:to_a).flatten
    begin
      self.pickup_code = (0...7).map { o[rand(o.length)] }.join
    end while self.class.exists?(pickup_code: self.pickup_code)
  end

end
