# == Schema Information
#
# Table name: edibles
#
#  id             :bigint           not null, primary key
#  food_type      :string
#  mg_per_serving :integer
#  name           :string
#  strain         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  brand_id       :bigint           not null
#
# Indexes
#
#  index_edibles_on_brand_id  (brand_id)
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id)
#
class Edible < ApplicationRecord
  include CannabisProduct

  validates :thc, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
