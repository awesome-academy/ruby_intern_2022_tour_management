class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :async, :confirmable, :lockable
  before_save :downcase_email

  enum role: {normal: 0, admin: 1}

  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.user.length.name_max}
  validates :email, presence: true, length: {maximum:
    Settings.user.length.email_max},
    uniqueness: true
  validate :password_format

  def booked_schedule? schedule_id
    bookings.any?{|b| b.tour_schedule_id == schedule_id}
  end

  private
  def downcase_email
    email.downcase!
  end

  def password_format
    return if password =~ Settings.user.password_regex.constain_digit &&
              password =~ Settings.user.password_regex.constain_upercase &&
              password =~ Settings.user.password_regex.constain_lowcase

    errors.add :user, I18n.t(".password_format_error")
  end
end
