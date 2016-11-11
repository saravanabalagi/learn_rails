class User < ApplicationRecord
  rolify
  has_secure_password

  before_create :randomize_id, :titleize_name

  validates :password, length: { minimum: 8 }, allow_nil: false
  validates :email, format: { with: /\A.+@.+$\Z/ }
  validates :mobile, length: { is: 10 }

  validates_presence_of :name, :email, :mobile, :password
  validates_uniqueness_of :mobile, :email

  has_many :addresses
  has_many :orders
  has_many :coupons, as: :couponable

  def as_json(options={})
    options[:except] ||= [:password_digest]
    super(options)
  end

  private
  def randomize_id
    begin
      self.id = SecureRandom.random_number(1_000_000)
    end while User.where(id: self.id).exists?
  end

  def titleize_name
    temp = self.name.to_s.squish
    temp = temp.gsub(/[^A-Za-z]/, '')
    temp = temp.titleize
    self.name = temp
  end

end
