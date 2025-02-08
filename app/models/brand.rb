# == Schema Information
#
# Table name: brands
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Brand < ApplicationRecord
  include SearchScope

  search_by :name

  has_many :flowers
  has_many :edibles
  has_many :concentrates
  has_many :pre_rolls

  has_one_attached :avatar do |attachable|
    attachable.variant :medium, resize_to_fill: [ 200, 200 ]
  end
end
