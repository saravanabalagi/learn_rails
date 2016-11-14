class Coupon < ApplicationRecord
  belongs_to :user
  belongs_to :couponable, polymorphic: true
  has_many :orders

  validates_presence_of :user
  validates_presence_of :name, :description, :available, :affects_surcharges, :expiry
  validates_uniqueness_of :name

  rails_admin do
    edit do
      configure :orders do
        hide
      end
    end
  end
end
