require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  before :each do
    controller.stubs(:validate_slack_token).returns(nil)
  end

  describe 'GET #index' do
    it 'returns all projects with associated users' do
      project = Project.create!(name: 'Site da Xuxa')
      project.users.create!(name: 'Denis')
      project.users.create!(name: 'Marcola')
      message = "`Projetos em andamento:\n\t- Site da Xuxa:\n\t\t- Denis\n\t\t- Marcola\n`"
      SlackAPI.expects(:respond_url).with(content: message, response_url: "www.central.com", user_name: "denner_maia")
      get :index, params: {response_url: 'www.central.com', user_name: "denner_maia"}
    end
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
