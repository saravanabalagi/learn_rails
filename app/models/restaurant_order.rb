class RestaurantOrder < ApplicationRecord
  belongs_to :order
  belongs_to :restaurant
  belongs_to :order_status
  belongs_to :coupon

  has_many :order_items, :dependent => :destroy
  accepts_nested_attributes_for :order_items, allow_destroy: true

  before_create :set_pickup_code

  def ordered_at
    self.order.ordered_at
  end

  def total
    total = 0
    self.order_items.each do |order_item|
      total += order_item.price
    end
    total
  end

  def payment_method_id
    self.order.payment_method_id
  end

  private
  def set_pickup_code
    o = [('0'..'9'), ('A'..'Z')].map(&:to_a).flatten
    begin
      self.pickup_code = (0...7).map { o[rand(o.length)] }.join
    end while self.class.exists?(pickup_code: self.pickup_code)
  end

end
