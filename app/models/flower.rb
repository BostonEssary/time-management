class Flower < ApplicationRecord
  STRAINS = [ "sativa", "indica", "hybrid" ].freeze

  belongs_to :brand
  has_one_attached :avatar
  has_many_attached :images

  validates :name, presence: true
  validates :name, uniqueness: { scope: :brand, message: "A product with that name already exists for that brand" }
end
