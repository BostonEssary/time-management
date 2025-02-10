module CannabisProduct
  extend ActiveSupport::Concern

  included do
    STRAINS = [ "sativa", "indica", "hybrid" ].freeze
    STRAIN_EFFECTS = {
      "sativa" => <<~DESC.squish,
        Sativa strains are known for their energizing, uplifting effects. They typically promote#{' '}
        creativity, focus, and mental clarity, making them popular for daytime use. Users often#{' '}
        experience increased energy and enhanced mood, perfect for social activities, creative#{' '}
        projects, or staying productive throughout the day.
      DESC

      "indica" => <<~DESC.squish,
        Indica strains are known for their relaxing, sedative effects. They are often used to#{' '}
        treat pain, inflammation, and insomnia. Users often experience a sense of calm and#{' '}
        relaxation, perfect for unwinding after a long day or before bedtime.
      DESC

      "hybrid" => <<~DESC.squish
        Hybrid strains are a combination of sativa and indica effects. They are known for their#{' '}
        balanced effects, making them popular for a wide range of activities. Users often experience#{' '}
        a sense of balance and relaxation, perfect for social activities, creative projects, or#{' '}
        staying productive throughout the day.
      DESC
    }.freeze

    belongs_to :brand

    has_one_attached :avatar do |attachable|
      attachable.variant :small_thumb, resize_to_fill: [ 50, 50 ]
      attachable.variant :thumb, resize_to_fill: [ 100, 100 ]
      attachable.variant :medium, resize_to_fill: [ 200, 200 ]
      attachable.variant :large, resize_to_fill: [ 400, 400 ]
    end

    has_many_attached :images do |attachable|
      attachable.variant :thumb, resize_to_fill: [ 250, 250 ]
      attachable.variant :medium, resize_to_fill: [ 800, 800 ]
    end

    validates :name, :avatar, :images, presence: true
    validates :strain, presence: true, inclusion: { in: STRAINS }
    validates :name, uniqueness: { scope: :brand, message: "A product with that name already exists for that brand" }
  end

  def strain_effects
    STRAIN_EFFECTS[strain]
  end

  def latest_review
    ratings.last
  end
end
