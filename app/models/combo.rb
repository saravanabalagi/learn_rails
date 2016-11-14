class Combo < ApplicationRecord
  has_and_belongs_to_many :dishes
  has_many :order_items, as: :purchasable
  has_many :coupons, as: :couponable

  validates_presence_of :name, :discount
  validates_uniqueness_of :name

  def price
    price = 0
    self.dishes.each do |dish|
      price += dish.price
    end
    price
  end

  rails_admin do
    edit do
      configure :coupons do
        hide
      end
      configure :order_items do
        hide
      end
    end
  end
end
