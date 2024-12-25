require 'rails_helper'

RSpec.describe "Follows", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end
  describe 'POST /follows' do
    let(:user1) { create(:user) }

    context 'with good params' do
      subject { post follows_path, params: { user_id: user1.id } }

      it 'should return a 302 if the response was successful' do
        subject
        expect(response).to have_http_status(302)
      end

      it 'should create a new follow' do
        expect { subject }.to change(Follow, :count).by(1)
      end

      it 'should redirect to the followee user show page' do
        subject
        expect(response).to redirect_to user_path(user1.id)
      end
    end

    context 'with bad params' do
      subject { post follows_path, params: { user_id: nil } }

      it 'returns a 422 when no id is passed' do
        subject
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /follow/:id' do
    let(:user1) { create(:user) }
    let!(:follow) { create(:follow, follower: user, followee: user1) }

    context 'with an existing follow id' do
      subject { delete follow_path(follow.id) }

      it 'should have an http status of 302' do
        subject
        expect(response).to have_http_status(302)
      end

      it 'should delete a follow' do
        expect { subject }.to change(Follow, :count).by(-1)
      end
    end
  end
end
