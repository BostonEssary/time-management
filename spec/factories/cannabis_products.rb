FactoryBot.define do
  factory :cannabis_product, class: nil do
    association :brand
    name { Faker::Cannabis.strain }
    strain { Flower::STRAINS.sample }

    after(:build) do |flower|
      flower.images.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
        filename: 'test_image.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
