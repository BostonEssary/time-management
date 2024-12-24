require 'rails_helper'

RSpec.describe "Users", type: :request do
    let(:user) { create(:user) }
    before do
      sign_in user
    end
    describe "GET /:id" do
      it "returns http success if the user exists" do
        get user_path(user.id)
        expect(response).to have_http_status(:success)
      end

      it 'returns a 404 if the user does not exist' do
        get user_path(User.maximum(:id).next)
        expect(response).to have_http_status(404)
      end

      context 'when the user is not signed in' do
        before do
          sign_out user
        end

        it 'redirects the user to the sign in page' do
          get user_path(user.id)
          expect(response).to have_http_status(302)
        end
      end
    end
  end
