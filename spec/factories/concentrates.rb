# == Schema Information
#
# Table name: concentrates
#
#  id               :bigint           not null, primary key
#  concentrate_type :string
#  name             :string
#  strain           :string
#  thc              :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  brand_id         :bigint           not null
#
# Indexes
#
#  index_concentrates_on_brand_id  (brand_id)
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id)
#
FactoryBot.define do
  factory :concentrate do
    strain { "MyString" }
    concentrate_type { "MyString" }
    brand { nil }
    name { "MyString" }
    thc { 1.5 }
  end
end
