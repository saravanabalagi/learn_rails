class VariantCategory < ApplicationRecord
  has_many :variants
  has_many :add_on_type_links, as: :addonable

  validates_presence_of :name
end
