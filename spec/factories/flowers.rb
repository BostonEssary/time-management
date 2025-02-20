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
  factory :flower, parent: :cannabis_product do
    thc { Faker::Number.between(from: 10.0, to: 35.0).round(1) }
  end
end
