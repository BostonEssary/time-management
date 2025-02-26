# == Schema Information
#
# Table name: pre_rolls
#
#  id         :bigint           not null, primary key
#  infused    :boolean
#  name       :string
#  strain     :string
#  thc        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  brand_id   :bigint           not null
#
# Indexes
#
#  index_pre_rolls_on_brand_id  (brand_id)
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id)
#
class PreRoll < ApplicationRecord
  include CannabisProduct

  has_many :ratings, as: :ratable
  has_many :product_effects, as: :effectable, dependent: :destroy
  has_many :effects, through: :product_effects
  validates :thc, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  # Scopes
  scope :with_ratings_and_score, -> {
    includes(ratings: :user)
      .select("pre_rolls.*, COUNT(ratings.id) as ratings_count, AVG(ratings.score) as average_score")
      .left_joins(:ratings)
      .group("pre_rolls.id")
  }

  scope :filter_by_strain, ->(strain) {
    where("LOWER(strain) = ?", strain.downcase) if strain.present?
  }

  scope :filter_by_infused, ->(infused) {
    where(infused: infused == "true") if infused.present?
  }

  scope :search_by_term, ->(query) {
    return unless query.present?

    joins(:brand).where(
      "pre_rolls.name ILIKE :query OR pre_rolls.strain ILIKE :query OR brands.name ILIKE :query",
      query: "%#{query}%"
    )
  }

  # Class methods
  def self.sort_by_param(sort_param)
    case sort_param
    when "name_asc"
      order("pre_rolls.name ASC")
    when "name_desc"
      order("pre_rolls.name DESC")
    when "thc_desc"
      order("pre_rolls.thc DESC NULLS LAST")
    when "thc_asc"
      order("pre_rolls.thc ASC NULLS LAST")
    when "rating_desc"
      order("AVG(ratings.score) DESC NULLS LAST")
    when "rating_asc"
      order("AVG(ratings.score) ASC NULLS LAST")
    else
      order("pre_rolls.created_at DESC") # Default sort
    end
  end

  def self.fetch_last_reviews(pre_rolls)
    Rating.select("DISTINCT ON (ratable_id) *")
          .where(ratable_type: "PreRoll", ratable_id: pre_rolls.map(&:id))
          .order("ratable_id, created_at DESC")
          .includes(:user)
          .index_by(&:ratable_id)
  end
end
