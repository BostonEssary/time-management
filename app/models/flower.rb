class Flower < ApplicationRecord
  belongs_to :brand

  validates :name, presence: true
  validates :name, uniqueness: { scope: :brand, message: "#{brand.name} already has a product named #{name}" }
end
