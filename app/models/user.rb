# == Schema Information
#
# Table name: users
#
#  id                      :bigint           not null, primary key
#  consumption_preferences :string           default([]), is an Array
#  date_of_birth           :date
#  email                   :string           default(""), not null
#  encrypted_password      :string           default(""), not null
#  experience_level        :string
#  remember_created_at     :datetime
#  reset_password_sent_at  :datetime
#  reset_password_token    :string
#  username                :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  EXPERIENCE_LEVELS = [ "sapling", "mature", "old growth" ]
  CONSUMPTION_METHODS = [ "bongs", "joints", "blunts", "edibles", "concentrates" ]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :follower_relationships, class_name: "Follow", foreign_key: "followee_id"
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :followee_relationships, class_name: "Follow", foreign_key: "follower_id"
  has_many :followees, through: :followee_relationships, source: :followee

  validates_uniqueness_of :username
  validates :username, presence: true
  validates :date_of_birth, comparison: { less_than_or_equal_to: 21.years.ago, message: "You must be 21 or older." }
end
