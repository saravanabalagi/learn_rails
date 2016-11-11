class DishVariant < ApplicationRecord
  belongs_to :dish
  belongs_to :food_label
  belongs_to :variant
  has_many :add_on_type_links, as: :addonable
  has_many :feel_links, as: :feelable
  has_many :order_items, as: :purchasable

  # validates_presence_of :dish
  validates_presence_of :variant
  validates_presence_of :price

  after_initialize :defaults, unless: :persisted?

  def name
    if self.price.present? && self.variant.present? && self.dish.present? && self.dish.name.present?
      self.dish.name + ': ' + self.variant.name + ' (' + self.price.to_s + ')'
    end
  end

  private
  def defaults
    self.food_label ||= FoodLabel.find_by_name('Veg')
    self.variant ||= Variant.find_by_name('Default')
  end

end
