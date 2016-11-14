class RestaurantTiming < ApplicationRecord
  belongs_to :restaurant

  # validates_presence_of :restaurant
  validates_presence_of :opening_time, :closing_time

  def name
    self.opening_time.strftime('%H:%M') + ' - ' + self.closing_time.strftime('%H:%M') if self.opening_time.present? && seld.closing_time.present?
  end
end
