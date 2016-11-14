class PackagingCentre < ApplicationRecord
  has_many :locations
  has_many :coupons, as: :couponable

  validates_presence_of :name
  validates_uniqueness_of :name

  rails_admin do
    edit do
      configure :coupons do
        hide
      end
    end
  end
end
