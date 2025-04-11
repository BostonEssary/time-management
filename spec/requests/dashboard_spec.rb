require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  describe "GET /dashboard" do
    let(:user) { create(:user) }

    it "returns http success if user is logged in" do
      sign_in user
      get dashboard_path
      expect(response).to have_http_status(:success)
    end

    it "redirects to root path if user is not logged in" do
      get dashboard_path
      expect(response).to redirect_to(user_session_path)
    end
  end
end
