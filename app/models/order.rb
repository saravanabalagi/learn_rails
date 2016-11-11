class Order < ApplicationRecord
  belongs_to :user
  belongs_to :order_status
  belongs_to :address
  belongs_to :payment_method
  has_many :order_items

  validates_presence_of :user, :order_status, :address, :payment_method
  # validates_presence_of :sub_total, :delivery, :vat, :total

  after_create :updateTotal

  include ActionView::Helpers::DateHelper
  def name
    if self.total.present? && self.created_at.present?
      'Rs. ' + self.total.to_s + ' (' + time_ago_in_words(self.created_at) + ' ago)'
    end
  end

  def updateTotal
    updateSubTotal
    updateVat
    updateDelivery
    self.total = self.sub_total + self.vat + self.delivery
    self.save
  end

  private

  def updateSubTotal
    self.sub_total = 0
    self.order_items.each do |order_item|
      self.sub_total += order_item.price
    end
  end

  def updateVat
    self.vat = self.sub_total * 0.02
  end

  def updateDelivery
    self.delivery = (self.sub_total < 200) ? 30 : 40
  end

end
