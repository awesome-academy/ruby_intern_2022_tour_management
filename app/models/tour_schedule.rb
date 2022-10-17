class TourSchedule < ApplicationRecord
  belongs_to :tour
  has_many :bookings, dependent: :destroy

  ALLOWED_PARAMS = %i(start_date end_date).freeze

  scope :by_start_date, (lambda do |start_date|
    where "start_date >= ?", start_date.presence || DateTime.now
  end)
  scope :by_end_date, (lambda do |end_date|
    where "end_date <= ?", end_date if end_date.present?
  end)
end
