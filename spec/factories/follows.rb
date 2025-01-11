# == Schema Information
#
# Table name: follows
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followee_id :bigint
#  follower_id :bigint
#
# Indexes
#
#  index_follows_on_followee_id                  (followee_id)
#  index_follows_on_followee_id_and_follower_id  (followee_id,follower_id) UNIQUE
#  index_follows_on_follower_id                  (follower_id)
#
# Foreign Keys
#
#  fk_rails_...  (followee_id => users.id)
#  fk_rails_...  (follower_id => users.id)
#
FactoryBot.define do
  factory :follow do
    association :follower, factory: :user
    association :followee, factory: :user
  end
end
