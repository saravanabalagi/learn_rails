class RestaurantPhone < ApplicationRecord
  belongs_to :phone_type
  belongs_to :restaurant

  before_create :trim_phone
  # validates_presence_of :phone_type, :restaurant
  validates_presence_of :value

  def name
    self.value
  end

  private
  def trim_phone
    temp = self.value.to_s
    temp = temp.sub(/^\+91/,'')
    temp = temp.gsub(/[^0-9]/, '')
    temp = temp.sub(/^[0]+/,'')
    temp = '+91' + temp
    self.value = temp
  end

end
