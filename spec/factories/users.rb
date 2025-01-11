# == Schema Information
#
# Table name: users
#
#  id                      :bigint           not null, primary key
#  consumption_preferences :string           default([]), is an Array
#  date_of_birth           :date
#  email                   :string           default(""), not null
#  encrypted_password      :string           default(""), not null
#  experience_level        :string
#  remember_created_at     :datetime
#  reset_password_sent_at  :datetime
#  reset_password_token    :string
#  username                :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    date_of_birth { Faker::Date.birthday(min_age: 21) }
    experience_level { User::EXPERIENCE_LEVELS.sample }
  end
end
