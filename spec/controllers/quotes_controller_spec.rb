require 'rails_helper'

RSpec.describe QuotesController, type: :controller do

  describe "GET #index" do
    it "returns a 200 OK status" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    context "when auth token is invalid" do
      it "returns a 403 FORBIDDEN status" do
        post :create, params: { token: "invalid_token" }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
