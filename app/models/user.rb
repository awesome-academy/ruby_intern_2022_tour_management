class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_save :downcase_email

  enum role: {normal: 0, admin: 1}

  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.user.length.name_max}
  validates :email, presence: true, length: {maximum:
    Settings.user.length.email_max},
    uniqueness: true

  def booked_schedule? schedule_id
    bookings.any?{|b| b.tour_schedule_id == schedule_id}
  end

  private
  def downcase_email
    email.downcase!
  end
end
