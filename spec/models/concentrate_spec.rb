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
require 'rails_helper'

RSpec.describe Concentrate, type: :model do
  it_behaves_like 'cannabis_product', { thc: 24, concentrate_type: 'rosin' }
end
