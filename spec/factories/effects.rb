# == Schema Information
#
# Table name: effects
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_effects_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :effect do
    description { "MyText" }
    name { "MyString" }
    effectable { nil }
  end
end
