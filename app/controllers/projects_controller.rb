class ProjectsController < ApplicationController
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

  def validate_slack_token
    render json: {}, status: :forbidden unless params[:token] == ENV["SLACK_AUTH_TOKEN"]
  end

  def project_params
    params.permit(:name)
  end
end
