require 'rails_helper'

RSpec.describe "Flowers", type: :request do
  let(:flower) { create(:flower) }
  describe "GET /index" do
    it "returns http success" do
      get "/flowers"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/flowers/#{flower.id}"
      expect(response).to have_http_status(:success)
    end
  end

  context "authenticated" do
    let(:user) { create(:user) }
    let(:brand) { create(:brand) }
    before do
      sign_in user
    end

    describe "GET /new" do
      it "returns http success" do
        get "/flowers/new"
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST /create" do
      let(:flower_params) do
        attributes = attributes_for(:flower)
        file = fixture_file_upload(
          Rails.root.join('spec/fixtures/files/test_image.jpg'),
          'image/jpeg'
        )
        attributes.merge(images: [ file ], brand_id: brand.id)
      end
      it "returns http success" do
        post "/flowers", params: { flower: flower_params }
        expect(response).to have_http_status(:redirect)
      end
    end

    context "when not authenticated" do
      before do
        sign_out user
      end

      it "returns http redirect" do
        get "/flowers/new"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
