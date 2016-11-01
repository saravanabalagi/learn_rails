class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :dish

  validates_presence_of :user, :dish
  validates_presence_of :stars
  validates_numericality_of :stars, :in => 1..5
end
