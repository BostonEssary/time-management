class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  validates_uniqueness_of :username
  validates :date_of_birth, comparison: { less_than_or_equal_to: 21.years.ago, message: "You must be 21 or older." }
end
