# == Schema Information
#
# Table name: flowers
#
#  id         :bigint           not null, primary key
#  name       :string
#  strain     :string
#  thc        :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  brand_id   :bigint           not null
#
# Indexes
#
#  index_flowers_on_brand_id           (brand_id)
#  index_flowers_on_name_and_brand_id  (name,brand_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id)
#
FactoryBot.define do
  factory :flower do
    Brand { nil }
    name { "MyString" }
    thc { 1.5 }
    strain { "MyString" }
  end
end
