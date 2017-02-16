class Order < ApplicationRecord
  belongs_to :user
  belongs_to :order_status
  belongs_to :payment_method
  has_many :order_items, :dependent => :destroy

  validates_presence_of :user
  # validates_presence_of :sub_total, :delivery, :vat, :total

  before_create :set_order_status

  accepts_nested_attributes_for :order_items, allow_destroy: true

  include ActionView::Helpers::DateHelper
  def name
    if self.total.present? && self.created_at.present?
      'Rs. ' + self.total.to_s + ' (' + time_ago_in_words(self.created_at) + ' ago)'
    end
  end

  def purchase_by_cod
    self.order_status = OrderStatus.find_by(name: 'Purchased')
    self.payment_method = PaymentMethod.find_by(name: 'COD')
    self.ordered_at = DateTime.now
    self.save
  end

  def set_order_status
    self.order_status = OrderStatus.find_by(name: 'Initiated')
  end

  #TODO update ordered_at when order_status changes
  def update_time
    self.ordered_at = DateTime.now
    self.save
  end

  def update_total
    update_sub_total
    update_vat
    update_delivery
    self.total = self.sub_total + self.vat + self.delivery
    self.save
  end

  private

  def update_sub_total
    self.sub_total = 0
    self.order_items.each do |order_item|
      self.sub_total += order_item.price
    end
  end

  def update_vat
    self.vat = self.sub_total * 0.02
  end

  def update_delivery
    self.delivery = (self.sub_total < 200) ? 30 : 40
  end

end
