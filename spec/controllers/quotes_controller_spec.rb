require 'rails_helper'

RSpec.describe QuotesController, type: :controller do

  describe "GET #index" do
    it "returns a 200 OK status" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    let(:invalid_token_params) {
      {
        token: "invalid_token",
        user_name: "user_name",
        text: "text"
      }
    }
    context "when auth token is invalid" do
      it "returns a 403 FORBIDDEN status" do
        post :create, params: invalid_token_params
        expect(response).to have_http_status(:forbidden)
      end

      it "doesn't create a new quote" do
        expect { post :create, params: invalid_token_params }.to_not change(Quote, :count)
      end
    end

    context "when params are valid to create a quote" do
      let(:valid_quote_params) {
        {
          token: "valid_token",
          user_name: "user_name",
          text: "text",
          response_url: "https://hooks.slack.com/commands/1234/"
        }
      }

      around do |example|
        ClimateControl.modify SLACK_AUTH_TOKEN: 'valid_token' do
          example.run
        end
      end

      it "returns a 200 OK status" do
          post :create, params: valid_quote_params
          expect(response).to have_http_status(:ok)
      end

      it "creates a quote" do
        expect { post :create, params: valid_quote_params }.to change(Quote, :count).by 1
      end
    end

    context "when params are invalid to create a quote" do
      let(:invalid_quote_params) {
        {
          token: "valid_token",
          user_name: "user_name",
          text: "",
          response_url: "https://hooks.slack.com/commands/1234/"
        }
      }

      it "respond with a json" do
        post :create, params: invalid_quote_params
        expect(response.content_type).to eq "application/json"
      end

      it "returns a 403 FORBIDDEN status" do
        post :create, params: invalid_quote_params
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
