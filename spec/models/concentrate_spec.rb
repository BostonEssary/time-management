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
require 'rails_helper'

RSpec.describe Concentrate, type: :model do
  subject(:concentrate) { build(:concentrate) }


  describe 'included concerns' do
    it_behaves_like 'cannabis_product', additional_attrs: { thc: 24, category: 'rosin' }
  end

  describe 'validations' do
    context 'when all attrs are valid' do
      it 'is valid' do
        expect(concentrate).to be_valid
      end
    end

    describe 'THC validations' do
     context 'when thc is nil' do
       before { concentrate.thc = nil }
       it { is_expected.to be_invalid }
     end

     context 'when thc is less than 0' do
       before { concentrate.thc = -1 }
       it { is_expected.to be_invalid }
     end

     context 'when thc is greater than 100' do
       before { concentrate.thc = 101 }
       it { is_expected.to be_invalid }
     end

     context 'when thc is within valid range' do
       before { concentrate.thc = 50 }
       it { is_expected.to be_valid }
     end
   end
  end
end
