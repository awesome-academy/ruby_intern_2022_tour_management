class TourSchedule < ApplicationRecord
  belongs_to :tour
  has_many :bookings, dependent: :destroy

  scope :get_from_current_day, ->{where "start_date >= ?", DateTime.now}
end
