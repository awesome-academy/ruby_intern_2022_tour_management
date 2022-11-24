FactoryBot.define do
  factory :user do
    name{FFaker::Name.name}
    email{"example@gmail.com"}
    password{"123456Qq"}
    password_confirmation{"123456Qq"}
    phone_number{"0432543523"}
    info{"this is a info"}
    role{1}
    confirmed_at{Time.now.utc}
    confirmation_sent_at{Time.now.utc}
  end
end
