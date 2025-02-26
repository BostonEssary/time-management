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
class Concentrate < ApplicationRecord
  include CannabisProduct

  CATEGORIES = [
    "Live Resin",
    "Shatter",
    "Rosin",
    "Kief",
    "Budder",
    "Crumble",
    "Applicators",
    "Sugar",
    "Sauce",
    "Isolate",
    "Badder"
  ]

  has_many :ratings, as: :ratable
  has_many :product_effects, as: :effectable, dependent: :destroy
  has_many :effects, through: :product_effects

  validates :category, presence: true
  validates :thc, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  # Scopes
  scope :with_ratings_and_score, -> {
    includes(ratings: :user)
      .select("concentrates.*, COUNT(ratings.id) as ratings_count, AVG(ratings.score) as average_score")
      .left_joins(:ratings)
      .group("concentrates.id")
  }

  scope :filter_by_strain, ->(strain) {
    where("LOWER(strain) = ?", strain.downcase) if strain.present?
  }

  scope :filter_by_category, ->(category) {
    where("LOWER(category) = ?", category.downcase) if category.present?
  }

  scope :search_by_term, ->(query) {
    return unless query.present?

    joins(:brand).where(
      "concentrates.name ILIKE :query OR concentrates.strain ILIKE :query OR concentrates.category ILIKE :query OR brands.name ILIKE :query",
      query: "%#{query}%"
    )
  }

  # Class methods
  def self.sort_by_param(sort_param)
    case sort_param
    when "name_asc"
      order("concentrates.name ASC")
    when "name_desc"
      order("concentrates.name DESC")
    when "thc_desc"
      order("concentrates.thc DESC NULLS LAST")
    when "thc_asc"
      order("concentrates.thc ASC NULLS LAST")
    when "rating_desc"
      order("AVG(ratings.score) DESC NULLS LAST")
    when "rating_asc"
      order("AVG(ratings.score) ASC NULLS LAST")
    when "category_asc"
      order("concentrates.category ASC")
    when "category_desc"
      order("concentrates.category DESC")
    else
      order("concentrates.created_at DESC") # Default sort
    end
  end

  def self.fetch_last_reviews(concentrates)
    Rating.select("DISTINCT ON (ratable_id) *")
          .where(ratable_type: "Concentrate", ratable_id: concentrates.map(&:id))
          .order("ratable_id, created_at DESC")
          .includes(:user)
          .index_by(&:ratable_id)
  end
end
