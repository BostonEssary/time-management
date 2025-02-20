# == Schema Information
#
# Table name: effects
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_effects_on_name  (name) UNIQUE
#
class Effect < ApplicationRecord
  has_many :product_effects, dependent: :destroy
  has_many :flowers, through: :product_effects, source: :effectable, source_type: "Flower"
  has_many :pre_rolls, through: :product_effects, source: :effectable, source_type: "PreRoll"
  has_many :edibles, through: :product_effects, source: :effectable, source_type: "Edible"
  has_many :concentrates, through: :product_effects, source: :effectable, source_type: "Concentrate"

  validates :name, presence: true, uniqueness: true
end
