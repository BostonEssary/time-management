# == Schema Information
#
# Table name: ratings
#
#  id           :bigint           not null, primary key
#  comment      :text
#  ratable_type :string           not null
#  score        :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  ratable_id   :bigint           not null
#  user_id      :bigint
#
# Indexes
#
#  index_ratings_on_ratable  (ratable_type,ratable_id)
#  index_ratings_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Rating < ApplicationRecord
  belongs_to :ratable, polymorphic: true
  belongs_to :user
  has_one_attached :image

  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :user, presence: true
end
