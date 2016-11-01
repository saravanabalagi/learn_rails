class AddOnType < ApplicationRecord
  has_many :add_ons
  has_many :add_on_type_links

  validates_presence_of :name
  validates_uniqueness_of :name
end
