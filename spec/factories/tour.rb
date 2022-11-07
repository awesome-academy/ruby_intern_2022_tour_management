FactoryBot.define do
  factory :tour do
    description{FFaker::Lorem.paragraph[0..3]}
    title{FFaker::Lorem.paragraph[0..4]}
    active{FFaker::Boolean.maybe}

    after(:build) do |tour|
      3.times do
        tour.images.attach(io: File.open("app/assets/images/placeimg_640_480_arch.jpg"),
                        filename: "placeimg_640_480_arch.jpg")
      end
    end
  end
end
