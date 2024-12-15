class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :follower_relationships, class_name: 'Follow', foreign_key: 'followee_id'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :followee_relationships, class_name: 'Follow', foreign_key: 'follower_id'
  has_many :followees, through: :followee_relationships, source: :followee

  validates_uniqueness_of :username
  validates :date_of_birth, comparison: { less_than_or_equal_to: 21.years.ago, message: "You must be 21 or older." }
end
