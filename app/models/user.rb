class User < ApplicationRecord
  rolify
  has_secure_password validations: false

  before_create :randomize_id, :titleize_name
  after_create :assign_default_role

  validates :password, length: { minimum: 8 }, allow_nil: true, unless: Proc.new { |u| u.uid.present? && u.provider.present? }
  validates :email, format: { with: /\A.+@.+$\Z/ }
  validates :mobile, length: { is: 10 }

  validates_presence_of :name, :email, :mobile
  validates_uniqueness_of :mobile, :email

  belongs_to :location
  has_many :orders
  has_many :coupons, as: :usable_by

  def as_json(options={})
    options[:except] ||= [:password_digest]
    super(options)
  end

  def set_password; nil; end

  def set_password=(value)
    return nil if value.blank?
    self.password = value
    self.password_confirmation = value
  end

  private

  def assign_default_role
    add_role :customer
  end

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

  rails_admin do
    configure(:set_password)
    configure(:password_digest) { hide }
    edit do
      exclude_fields :password
      include_fields :set_password
      configure(:coupons) { hide }
      configure(:orders) { hide }
      configure(:password, :string) { help 'Required. Minimum 8 Characters' }
      configure(:set_password) { help 'Leave blank to retain old password' }
      configure(:uid) { hide }
      configure(:provider) { hide }
    end
  end

end
