class Concentrate < ApplicationRecord
  include CannabisProduct

  belongs_to :brand

  validates :strain, presence: true, inclusion: { in: STRAINS }
  validates :concentrate_type, presence: true
  validates :thc, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
