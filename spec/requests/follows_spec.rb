require 'rails_helper'

RSpec.describe "Follows", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end
  describe 'POST /follows' do
    subject { post follows_path, params: { user_id: user1.id } }

    let(:user1) { create(:user) }

    it 'should create a new follow' do
      expect { subject }.to change(Follow, :count).to(1)
    end
  end
end
