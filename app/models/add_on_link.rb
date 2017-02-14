class AddOnLink < ApplicationRecord
  belongs_to :add_on
  belongs_to :add_on_type_link
  has_many :feel_links, as: :feelable

  has_and_belongs_to_many :order_items

  validates_presence_of :price
  validates_uniqueness_of :add_on, scope: :add_on_type_link

  accepts_nested_attributes_for :feel_links, allow_destroy: true

  def name
    if self.add_on.present? && self.add_on_type_link.present?
      self.add_on_type_link.name + ' ' + self.add_on.name
    end
  end
end
