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
