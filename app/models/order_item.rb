class OrderItem < ApplicationRecord
  belongs_to :purchasable, polymorphic: true
  belongs_to :order

  after_commit do
    self.order.reload.update_total
  end

  validates_presence_of :order
  validates_presence_of :quantity

  def name
    if self.quantity.present? && self.purchasable.present?
      name = 'Unknown'
      if self.purchasable_type == 'DishVariant'
        name = self.purchasable.dish.name
      elsif self.purchasable_type == 'Combo'
        name = self.purchasable.name
      end
      self.quantity.to_s + 'x ' + name
    end
  end

  def price
    json = self.ordered && self.ordered.length >= 2 ? JSON.parse(self.ordered) : nil
    if self.purchasable_type == 'DishVariant'
      price = DishVariant.find(self.purchasable_id).price
      json && json.has_key?('add_ons') && json['add_ons'].each do |add_on|
        price += AddOnLink.find(add_on).price
      end
      price * self.quantity
    elsif self.purchasable_type == 'Combo'
      price = 0
      json['dish_variants'].each do |dish_variant|
        price += DishVariant.find(dish_variant['id']).price
        dish_variant.has_key?('add_ons') &&  dish_variant['add_ons'].each do |add_on|
          price += AddOnLink.find(add_on).price
        end
      end
      price -= self.purchasable.discount
      price * self.quantity
    end
  end

end
