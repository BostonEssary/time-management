class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followee, class_name: "User"

  validates :follower, uniqeuess: { scope: :followee, message: "You can't follow the same person twice." }
end
