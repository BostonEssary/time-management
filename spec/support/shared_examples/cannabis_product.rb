RSpec.shared_examples "cannabis_product" do |additional_attrs: {}|
   let(:valid_attrs) {
        {
          name: 'name',
          brand_id: brand.id,
          avatar: test_image,
          images: [ test_image ],
          strain: described_class::STRAINS.sample
        }.merge(additional_attrs)
      }
   subject { described_class.new(valid_attrs) }
   let(:brand) { create(:brand) }
   let(:test_image) {
      Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg'), 'image/jpeg') }

   describe 'associations' do
      it { should belong_to(:brand) }
    end


   describe 'validations' do
     context 'when all required attributes are present' do
       it 'is valid' do
         expect(subject).to be_valid
       end
     end

     context 'when name is missing' do
       before { subject.name = nil }

       it 'is invalid' do
         expect(subject).to be_invalid
       end
     end

     context 'when name is already taken' do
       let(:dummy1) { described_class.new(brand_id: brand.id,
                                          name: subject.name,
                                          strain: 'indica',
                                          avatar: test_image,
                                          images: [ test_image ]) }
       it 'is invalid' do
          subject.save
          expect(dummy1).to be_invalid
        end
     end
   end
 end
