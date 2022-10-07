User.create!(name: "Phan Quang",
  email: "abc@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1,
  phone_number: "0034232342",
  info: "this is a info")

10.times do |n|
  name = Faker::name
  email= "abc#{n}@gmail.com"
  password = "123456"

  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
    phone_number: "0034232342",
    info: "this is a info")
end
