require 'rails_helper'

RSpec.describe QuotesController, type: :controller do

  describe "GET #index" do
    it "have http status 200" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
end
