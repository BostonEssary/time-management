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
class Concentrate < ApplicationRecord
  include CannabisProduct

  belongs_to :brand

  validates :strain, presence: true, inclusion: { in: STRAINS }
  validates :concentrate_type, presence: true
  validates :thc, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
