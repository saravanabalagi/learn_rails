class OrderItem < ApplicationRecord
  belongs_to :purchasable, polymorphic: true
  belongs_to :order

  validates_presence_of :order
  validates_presence_of :quantity

  def name
    if self.quantity.present? && self.purchasable.present?
      self.quantity.to_s + 'x ' + self.purchasable.name
    end
  end
end
