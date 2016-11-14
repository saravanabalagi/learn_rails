class VariantCategory < ApplicationRecord
  has_many :variants
  has_many :add_on_type_links, as: :addonable

  validates_presence_of :name

  rails_admin do
    edit do
      configure :add_on_type_links do
        hide
      end
    end
  end
end
