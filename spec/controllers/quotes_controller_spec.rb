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
      let(:invalid_token_params) {
        { token: "invalid_token", user_name: "user_name", text: "text" }
      }

      it "returns a 403 FORBIDDEN status" do
        post :create, params: invalid_token_params
        expect(response).to have_http_status(:forbidden)
      end

      it "doesn't create a new quote" do
        expect {
          post :create, params: invalid_token_params
        }.to_not change { Quote.count }
      end
    end
  end
end
