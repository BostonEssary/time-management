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
    factory :concentrate do
        brand
        name { Faker::Lorem.word }
        strain { CannabisProduct::STRAINS.sample }
        thc { Faker::Number.between(from: 10.0, to: 35.0).round(1) }
        category { Concentrate::CATEGORIES.sample }
        images {
            [ Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg'),
                                           'image/jpeg') ]
          }
        after(:build) do |concentrate|
          concentrate.images.attach(
            io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
            filename: 'test_image.jpg',
            content_type: 'image/jpeg'
          )
        end
      end
  end
