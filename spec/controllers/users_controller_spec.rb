require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "POST #create" do
    let(:valid_user_params) {
      {
        token: "some_token",
        user_name: "user_name",
        name: "user_name"
      }
    }

    before :each do
      controller.expects(:validate_slack_token).returns(nil)
    end

    it "returns a 200 OK status" do
      post :create, params: valid_user_params
      expect(response).to have_http_status(:ok)
    end

    it "creates a quote" do
      expect { post :create, params: valid_user_params }.to change(User, :count).by 1
    end
  end
end
