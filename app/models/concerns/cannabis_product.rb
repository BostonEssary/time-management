module CannabisProduct
  extend ActiveSupport::Concern

  included do
    STRAINS = [ "sativa", "indica", "hybrid" ].freeze

    belongs_to :brand

    has_one_attached :avatar do |attachable|
      attachable.variant :small_thumb, resize_to_fill: [ 50, 50 ]
      attachable.variant :thumb, resize_to_fill: [ 100, 100 ]
    end

    has_many_attached :images do |attachable|
      attachable.variant :thumb, resize_to_fill: [ 250, 250 ]
      attachable.variant :medium, resize_to_fill: [ 800, 800 ]
    end

    validates :name, :avatar, :images, presence: true
    validates :strain, presence: true, inclusion: { in: STRAINS }
    validates :name, uniqueness: { scope: :brand, message: "A product with that name already exists for that brand" }
  end
end
