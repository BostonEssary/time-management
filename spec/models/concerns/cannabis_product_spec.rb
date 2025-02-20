require 'rails_helper'

RSpec.describe CannabisProduct do
   let(:brand) { create(:brand) }
   let(:test_image) {
     Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg'), 'image/jpeg') }
   let!(:dummy) { Dummy.new(brand_id: brand.id,
                            name: 'Wow',
                            strain: 'indica',
                            avatar: test_image,
                            images: [ test_image ]) }


   describe 'associations' do
     subject { dummy }

     it { should belong_to(:brand) }
   end


   describe 'validations' do
     context 'when all required attributes are present' do
       it 'is valid' do
         expect(dummy).to be_valid
       end
     end

     context 'when name is missing' do
       before { dummy.name = nil }

       it 'is invalid' do
         expect(dummy).to be_invalid
       end
     end

     context 'when name is already taken' do
       let(:dummy1) { Dummy.new(brand_id: brand.id,
                                name: 'Wow',
                                strain: 'indica',
                                avatar: test_image,
                                images: [ test_image ]) }
       it 'is invalid' do
          dummy.save
          expect(dummy1).to be_invalid
        end
     end
   end
 end


class Dummy < ActiveRecord::Base
  self.table_name = 'flowers'

  include CannabisProduct
end
