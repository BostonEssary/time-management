# == Schema Information
#
# Table name: edibles
#
#  id             :bigint           not null, primary key
#  food_type      :string
#  mg_per_serving :integer
#  name           :string
#  strain         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  brand_id       :bigint           not null
#
# Indexes
#
#  index_edibles_on_brand_id  (brand_id)
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id)
#
class Edible < ApplicationRecord
  include CannabisProduct

  FOOD_TYPES = [
    "Gummies",
    "Chocolate",
    "Baked Goods",
    "Hard Candy",
    "Beverages",
    "Capsules",
    "Tinctures",
    "Mints",
    "Cooking Oil"
  ]

  has_many :ratings, as: :ratable
  has_many :product_effects, as: :effectable, dependent: :destroy
  has_many :effects, through: :product_effects

  validates :food_type, presence: true
  validates :mg_per_serving, presence: true, numericality: { greater_than: 0 }

  # Scopes
  scope :with_ratings_and_score, -> {
    includes(ratings: :user)
      .select("edibles.*, COUNT(ratings.id) as ratings_count, AVG(ratings.score) as average_score")
      .left_joins(:ratings)
      .group("edibles.id")
  }

  scope :filter_by_strain, ->(strain) {
    where("LOWER(strain) = ?", strain.downcase) if strain.present?
  }

  scope :filter_by_food_type, ->(food_type) {
    where("LOWER(food_type) = ?", food_type.downcase) if food_type.present?
  }

  scope :search_by_term, ->(query) {
    return unless query.present?

    joins(:brand).where(
      "edibles.name ILIKE :query OR edibles.strain ILIKE :query OR edibles.food_type ILIKE :query OR brands.name ILIKE :query",
      query: "%#{query}%"
    )
  }

  # Class methods
  def self.sort_by_param(sort_param)
    case sort_param
    when "name_asc"
      order("edibles.name ASC")
    when "name_desc"
      order("edibles.name DESC")
    when "mg_desc"
      order("edibles.mg_per_serving DESC NULLS LAST")
    when "mg_asc"
      order("edibles.mg_per_serving ASC NULLS LAST")
    when "rating_desc"
      order("AVG(ratings.score) DESC NULLS LAST")
    when "rating_asc"
      order("AVG(ratings.score) ASC NULLS LAST")
    when "food_type_asc"
      order("edibles.food_type ASC")
    when "food_type_desc"
      order("edibles.food_type DESC")
    else
      order("edibles.created_at DESC") # Default sort
    end
  end

  def self.fetch_last_reviews(edibles)
    Rating.select("DISTINCT ON (ratable_id) *")
          .where(ratable_type: "Edible", ratable_id: edibles.map(&:id))
          .order("ratable_id, created_at DESC")
          .includes(:user)
          .index_by(&:ratable_id)
  end
end
