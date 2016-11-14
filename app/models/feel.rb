class Feel < ApplicationRecord
  belongs_to :feel_category
  has_many :feel_links

  validates_presence_of :name
  validates_presence_of :feel_category
  validates_uniqueness_of :name

  accepts_nested_attributes_for :feel_links, allow_destroy: true

end
