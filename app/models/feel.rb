class Feel < ApplicationRecord
  belongs_to :feel_category
  has_many :feel_links

  validates_presence_of :name
  validates_presence_of :feel_category
  validates_uniqueness_of :name
end
