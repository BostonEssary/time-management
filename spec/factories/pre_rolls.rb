# == Schema Information
#
# Table name: pre_rolls
#
#  id         :bigint           not null, primary key
#  infused    :boolean
#  name       :string
#  strain     :string
#  thc        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  brand_id   :bigint           not null
#
# Indexes
#
#  index_pre_rolls_on_brand_id  (brand_id)
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id)
#
FactoryBot.define do
  factory :pre_roll do
    name { "MyString" }
    strain { "MyString" }
    thc { "MyString" }
    brand { nil }
    infused { false }
  end
end
