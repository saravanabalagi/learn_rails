class Brand < ApplicationRecord
  has_many :coupons, as: :couponable
  has_many :restaurants

  validates_presence_of :name
  validates_uniqueness_of :name, :business_name

  accepts_nested_attributes_for :restaurants, allow_destroy: true

  rails_admin do
    edit do
      configure :coupons do
        hide
      end
    end
  end
end
