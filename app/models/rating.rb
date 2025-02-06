# == Schema Information
#
# Table name: ratings
#
#  id           :bigint           not null, primary key
#  ratable_type :string           not null
#  score        :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  ratable_id   :bigint           not null
#
# Indexes
#
#  index_ratings_on_ratable  (ratable_type,ratable_id)
#
class Rating < ApplicationRecord
  belongs_to :ratable, polymorphic: true

  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
