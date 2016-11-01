class Location < ApplicationRecord
  belongs_to :packaging_centre
  belongs_to :city
  has_many :addresses
  has_many :restaurants
  has_many :coupons, as: :couponable

  validates_presence_of :city, :packaging_centre
  validates_presence_of :name
  validates_uniqueness_of :name

  rails_admin do
    configure :addresses do
      hide
    end
  end

end
