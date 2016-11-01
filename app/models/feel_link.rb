class FeelLink < ApplicationRecord
  belongs_to :feel
  belongs_to :feelable, polymorphic: true

  validates_presence_of :feel, :feelable
  validates_presence_of :scale
  validates_numericality_of :scale, in: 1..100
  validates_uniqueness_of :feel, scope: [:feelable_type, :feelable_id]

  def name
    if self.feel.present? && self.scale.present?
      self.feel.name + ' (' + self.scale.to_s + ')'
    end
  end
end
