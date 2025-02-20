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
require 'rails_helper'

RSpec.describe Follow, type: :model do
  let(:user) { create(:user) }
  let(:user1) { create(:user) }

  describe 'validations' do
    context 'uniqueness validations' do
      let!(:follow) { create(:follow, follower: user, followee: user1) }
      let(:follow1) { build(:follow, follower: user, followee: user1) }

      it ' should be invalid if another follow exists for this follower and followee' do
        expect(follow1).to be_invalid
      end
    end
  end
end
