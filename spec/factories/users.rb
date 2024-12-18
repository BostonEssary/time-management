FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    date_of_birth { Faker::Date.birthday(min_age: 21) }
    experience_level { User::EXPERIENCE_LEVELS.sample }
  end
end
