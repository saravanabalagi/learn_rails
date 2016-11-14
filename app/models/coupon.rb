class Coupon < ApplicationRecord
  belongs_to :coupon_category
  belongs_to :usable_by, polymorphic: true
  belongs_to :applied_on, polymorphic: true
  has_many :orders

  validates_presence_of :name, :description, :available, :expiry
  validates_uniqueness_of :name

  rails_admin do
    edit do
      configure :orders do
        hide
      end
    end
  end
end
