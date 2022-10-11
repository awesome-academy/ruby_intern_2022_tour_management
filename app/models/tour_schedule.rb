class TourSchedule < ApplicationRecord
  belongs_to :tour
  has_many :bookings, dependent: :destroy
end
