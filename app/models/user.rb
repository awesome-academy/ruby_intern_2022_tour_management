class User < ApplicationRecord
  before_save :downcase_email

  enum role: {normal: 0, admin: 1}

  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.user.length.name_max}
  validates :email, presence: true, length: {maximum:
    Settings.user.length.email_max},
    format: {with: Settings.user.email_regex},
    uniqueness: true
  validates :password, presence: true,
    length: {minimum: Settings.user.length.password_min}

  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end

      BCrypt::Password.create string, cost: cost
    end
  end

  private
  def downcase_email
    email.downcase!
  end
end
