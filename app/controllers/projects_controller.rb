class ProjectsController < ApplicationController
  protect_from_forgery except: [:create]
  before_action :validate_slack_token, only: [:create]

  def create
    project = Project.new(project_params)

    if project.save
      head :ok
    else
      render json: { response_type: "ephemeral", text: "Sorry, something went wrong. Please try again." }
    end
  end

  private

  def project_params
    params.permit(:name)
  end
end
