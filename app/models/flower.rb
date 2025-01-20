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
class Flower < ApplicationRecord
  STRAINS = [ "sativa", "indica", "hybrid" ].freeze

  belongs_to :brand

  has_one_attached :avatar do |attachable|
    attachable.variant :small_thumb, resize_to_fill: [ 50, 50 ]
    attachable.variant :thumb, resize_to_fill: [ 100, 100 ]
  end
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_fill: [ 500, 500 ]
    attachable.variant :medium, resize_to_fill: [ 800, 800 ]
  end

  validates :name, :avatar, :images, presence: true
  validates :name, uniqueness: { scope: :brand, message: "A product with that name already exists for that brand" }
end
