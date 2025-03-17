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
require 'rails_helper'

RSpec.describe PreRoll, type: :model do
  subject(:pre_roll) { build(:pre_roll) }

  describe 'included concerns' do
    it_behaves_like 'cannabis_product', additional_attrs: { infused: [ true, false ].sample, thc: 23 }
  end
end
