class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour_schedule
end
