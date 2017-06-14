require "rails_helper"

RSpec.describe UsersController, type: :controller do
  before :each do
    controller.expects(:validate_slack_token).returns(nil)
  end

  describe "POST #create" do
    let(:valid_user_params) {
      {
        token: "some_token",
        user_name: "user_name",
        name: "user_name"
      }
    }

    it "returns a 200 OK status" do
      post :create, params: valid_user_params
      expect(response).to have_http_status(:ok)
    end

    it "creates an user" do
      expect { post :create, params: valid_user_params }.to change(User, :count).by(1)
    end
  end

  describe "POST #destroy" do
    let!(:user) { User.create(name: "user_name") }
    it "destroys an user" do
      expect { post :destroy, params: { name: user.name } }.to change(User, :count).by(-1)
    end
  end

  describe "POST #allocate" do
    let!(:user) { User.create(name: "user_name") }
    let!(:project) { Project.create(name: "project_name") }
    it "allocates an user in a project" do
      post :allocate, params: { user_name: user.name, project_name: project.name }
      expect(user.projects.first).to eq(project)
    end
  end
end
