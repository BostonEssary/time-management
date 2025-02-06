# == Schema Information
#
# Table name: ratings
#
#  id           :bigint           not null, primary key
#  ratable_type :string           not null
#  score        :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  ratable_id   :bigint           not null
#
# Indexes
#
#  index_ratings_on_ratable  (ratable_type,ratable_id)
#
FactoryBot.define do
  factory :rating do
    score { 1 }
    ratable { nil }
  end
end
