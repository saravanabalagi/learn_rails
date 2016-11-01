class AddOn < ApplicationRecord
  belongs_to :add_on_type
  has_many :add_on_links

  # validates_presence_of :add_on_type
  validates_presence_of :name
  validates_uniqueness_of :name
end
