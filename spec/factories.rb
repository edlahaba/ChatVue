require 'faker'

FactoryBot.define do
  factory :user do
    username "Pepon_nieto"
    token ""
  end
  factory :other_user, class: User do
    username "Other_user"
    token ""
  end
  factory :random_user, class: User do
    username {Faker::Internet.user_name(7..12)}
    token ""
  end
  factory :second_user, class: User do
    username "seconduser"
    token ""
  end
  factory :room do
    name Faker::Overwatch.hero
  end
  factory :random_room, class: Room do
    name {Faker::Vehicle.vin}
  end
  factory :message do
    content "this is a message!"
  end
end