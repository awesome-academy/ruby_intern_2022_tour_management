FactoryBot.define do
  factory :tour_schedule do
    start_date{DateTime.now + 1.days}
    title{FFaker::Lorem.paragraph[0..4]}
    end_date{FFaker::Time.between(DateTime.now + 2.days,
                                  DateTime.now + 4.days)}

    association :tour
  end
end
