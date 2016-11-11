class Dish < ApplicationRecord
  belongs_to :restaurant
  belongs_to :dish_category
  has_many :dish_variants
  has_many :coupons, as: :couponable
  has_many :order_items, through: :dish_variants
  has_many :feel_links, as: :feelable
  has_and_belongs_to_many :cuisines
  has_and_belongs_to_many :combos

  mount_uploader :image, ImageUploader

  validates_presence_of :restaurant, :dish_category
  validates_presence_of :name

  def price
    self.dish_variants.maximum(:price)
  end

  rails_admin do
    list do
      configure :name do
        formatted_value do
          if bindings[:object].image.present?
            bindings[:view].tag(:span, {
                'style': 'color: #428bca',
                'data-toggle': 'popover',
                'data-trigger': 'click',
                'data-placement': 'bottom',
                'data-content': '<img src="' + bindings[:object].image.to_s + '" width=200 />',
                'title': 'Image'
            }) << value
          else
            value
          end
        end
      end
      configure :image do
        hide
      end
    end
  end

end
