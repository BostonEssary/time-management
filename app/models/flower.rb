class Flower < ApplicationRecord
  STRAINS = [ "sativa", "indica", "hybrid" ].freeze

  belongs_to :brand

  validates :name, presence: true
  validates :name, uniqueness: { scope: :brand, message: "A product with that name already exists for that brand" }
end
