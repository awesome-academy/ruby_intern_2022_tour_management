FactoryBot.define do
  factory :booking do
    status{Booking.statuses[:pending]}
    
    association :user
    association :tour_schedule
  end
end
