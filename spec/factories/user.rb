FactoryBot.define do
  factory :user do
    name{FFaker::Name.name}
    email{"example@gmail.com"}
    password{"123456"}
    password_confirmation{"123456"}
    phone_number{"0432543523"}
    info{"this is a info"}
    role{1}
  end
end
