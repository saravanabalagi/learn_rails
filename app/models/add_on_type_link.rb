class AddOnTypeLink < ApplicationRecord
  belongs_to :add_on_type
  belongs_to :addonable, polymorphic: true
  has_many :add_on_links

  validates_presence_of :add_on_type, :addonable
  validates_presence_of :min

  def name
    if addonable.present? && add_on_type.present?
      addonable.name + ': ' + add_on_type.name
    end
  end
end
