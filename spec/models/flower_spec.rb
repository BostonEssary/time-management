# == Schema Information
#
# Table name: flowers
#
#  id         :bigint           not null, primary key
#  name       :string
#  strain     :string
#  thc        :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  brand_id   :bigint           not null
#
# Indexes
#
#  index_flowers_on_brand_id           (brand_id)
#  index_flowers_on_name_and_brand_id  (name,brand_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id)
#
require 'rails_helper'

RSpec.describe Flower, type: :model do
  let(:brand) { create(:brand) }
  let(:test_image) {
 Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg'), 'image/jpeg') }

  let(:valid_attributes) do
    {
      name: "Purple Haze",
      strain: "sativa",
      thc: 18.5,
      brand: brand,
      avatar: test_image,
      images: [ test_image ]
    }
  end

  describe 'associations' do
    it { should belong_to(:brand) }
    it { should have_one_attached(:avatar) }
    it { should have_many_attached(:images) }
  end

  describe 'validations' do
    subject { create(:flower, valid_attributes) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:avatar) }
    it { should validate_presence_of(:images) }

    it 'validates uniqueness of name scoped to brand' do
      should validate_uniqueness_of(:name)
        .scoped_to(:brand_id)
        .with_message('A product with that name already exists for that brand')
    end
  end

  describe 'image variants' do
    let(:flower) { build(:flower, valid_attributes) }

    it 'has correct avatar variants' do
      expect(flower.avatar.variant(:small_thumb)).to be_present
      expect(flower.avatar.variant(:thumb)).to be_present
    end

    it 'has correct image variants' do
      expect(flower.images.first&.variant(:thumb)).to be_present
      expect(flower.images.first&.variant(:medium)).to be_present
    end
  end

  describe 'creation' do
    let(:flower) { build(:flower, valid_attributes) }

    it 'is valid with valid attributes' do
      expect(flower).to be_valid
    end

    it 'is not valid without a name' do
      flower.name = nil
      expect(flower).not_to be_valid
    end

    it 'is not valid without a brand' do
      flower.brand = nil
      expect(flower).not_to be_valid
    end

    it 'is not valid without an avatar' do
      flower.avatar = nil
      expect(flower).not_to be_valid
      expect(flower.errors[:avatar]).to include("can't be blank")
    end

    it 'is not valid without images' do
      flower.images = []
      expect(flower).not_to be_valid
      expect(flower.errors[:images]).to include("can't be blank")
    end
  end
end
