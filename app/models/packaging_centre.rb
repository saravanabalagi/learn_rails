class PackagingCentre < ApplicationRecord
  has_many :locations
  has_many :coupons, as: :usable_by
  has_many :coupons, as: :applied_on

  has_many :restaurants, through: :locations
  has_many :dishes, through: :restaurants
  has_many :dish_categories, -> {distinct}, through: :dishes

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
