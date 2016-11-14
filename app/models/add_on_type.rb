class AddOnType < ApplicationRecord
  has_many :add_ons
  has_many :add_on_type_links

  validates_presence_of :name
  validates_uniqueness_of :name

  accepts_nested_attributes_for :add_ons, allow_destroy: true

  rails_admin do
    edit do
      configure :add_on_type_links do
        hide
      end
    end
  end

end
