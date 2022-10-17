User.create!(name: "Phan Quang",
             email: "abc@gmail.com",
             password: "123456",
             password_confirmation: "123456",
             role: 1,
             phone_number: "0034232342",
             info: "admin here")

10.times do |n|
  name = Faker.name
  email = "abc#{n}@gmail.com"
  password = "123456"

  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               phone_number: "0034232342",
               info: "this is a info")
end

20.times do
  description = Faker::Lorem.paragraph(sentence_count: 3)
  title = Faker::Lorem.paragraph(sentence_count: 1)
  active = Faker::Boolean.boolean

  Tour.create!(description: description, title: title, active: active)
end

20.times do
  tour_id = Faker::Number.between from: 1, to: 10
  start_date = Faker::Date.forward(days: 3)
  end_date = Faker::Date.forward(days: 20)

  TourSchedule.create!(tour_id: tour_id, start_date: start_date,
                       end_date: end_date)
end
