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
class PreRoll < ApplicationRecord
  include CannabisProduct

  has_many :ratings, as: :ratable

  validates :thc, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
