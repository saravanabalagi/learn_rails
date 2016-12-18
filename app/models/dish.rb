class Dish < ApplicationRecord
  belongs_to :restaurant
  belongs_to :dish_category
  has_many :dish_variants
  has_many :coupons, as: :applied_on
  has_many :order_items, through: :dish_variants
  has_many :feel_links, as: :feelable
  has_and_belongs_to_many :cuisines
  has_and_belongs_to_many :combos

  has_one :packaging_centre, through: :restaurant

  mount_uploader :image, ImageUploader

  accepts_nested_attributes_for :dish_variants, allow_destroy: true
  accepts_nested_attributes_for :feel_links, allow_destroy: true

  validates_presence_of :restaurant, :dish_category
  validates_presence_of :name

  def price
    self.dish_variants.minimum(:price)
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
    edit do
      configure :coupons do
        hide
      end
      configure :order_items do
        hide
      end
      configure :combos do
        hide
      end
    end
  end

end
