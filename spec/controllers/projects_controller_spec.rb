require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  before :each do
    controller.expects(:validate_slack_token).returns(nil)
  end

  describe "POST #create" do
    let(:valid_project_params) {
      {
        token: "some_token",
        user_name: "user_name",
        text: "project_name"
      }
    }

    it "returns a 200 OK status" do
      post :create, params: valid_project_params
      expect(response).to have_http_status(:ok)
    end

    it "creates a project" do
      post :create, params: valid_project_params
      expect(Project.last.name).to eq valid_project_params[:text]
    end
  end

  describe "POST #destroy" do
    let!(:project) { Project.create(name: "project_name") }
    it "destroys an project" do
      expect { delete :destroy, params: { text: project.name } }.to change(Project, :count).by(-1)
    end
  end
end
