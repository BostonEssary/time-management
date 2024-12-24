require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /show" do
    it "returns http success" do
      get profile_path
      expect(response).to have_http_status(:success)
    end

    it 'has the correct username in the response' do
      get profile_path
      expect(response.body).to include(user.username)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get edit_profile_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /profile" do
    it 'redirects the user if the update was sucessful' do
      patch profile_path, params: { user: { username: 'cheese' } }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(profile_path)
    end

    it 'updates the user data when successful' do
      patch profile_path, params: { user: { username: 'dude' } }
      expect(user.reload.username).to eq('dude')
    end

    it 'returns a response of 422 if it received bad input' do
      patch profile_path(user.id), params: { user: { username: nil } }
      expect(response).to have_http_status(422)
    end
  end
end
