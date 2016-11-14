class City < ApplicationRecord
  has_many :locations
  has_many :coupons, as: :usable_by
  has_many :coupons, as: :applied_on

  validates_presence_of :name
  validates_uniqueness_of :name

  accepts_nested_attributes_for :locations, allow_destroy: true

  rails_admin do
    edit do
      configure :coupons do
        hide
      end
    end
  end
end
