class Location < ApplicationRecord
  belongs_to :city
  has_many :restaurants
  has_many :dishes, through: :restaurants
  has_many :dish_categories, -> { distinct }, through: :dishes
  has_many :coupons, as: :usable_by
  has_many :coupons, as: :applied_on

  validates_presence_of :city
  validates_presence_of :name
  validates_uniqueness_of :name

  accepts_nested_attributes_for :restaurants, allow_destroy: true

  rails_admin do
    edit do
      configure :coupons do
        hide
      end
    end
  end

end
