# == Schema Information
#
# Table name: concentrates
#
#  id         :bigint           not null, primary key
#  category   :string
#  name       :string
#  strain     :string
#  thc        :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  brand_id   :bigint           not null
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
  factory :concentrate, parent: :cannabis_product, class: 'Concentrate' do
    category { Concentrate::CATEGORIES.sample }
    thc { 1.5 }
  end
end
