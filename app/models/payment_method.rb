class PaymentMethod < ApplicationRecord
  has_many :orders

  validates_presence_of :name
  validates_uniqueness_of :name
end
