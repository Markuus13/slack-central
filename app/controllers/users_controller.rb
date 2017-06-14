class UsersController < ApplicationController
  protect_from_forgery except: [:create]
  before_action :validate_slack_token, only: [:create, :destroy, :allocate]

  def create
    user = User.new(project_params)

    if user.save
      head :ok
    else
      render json: { response_type: "ephemeral", text: "Sorry, something went wrong. Please try again." }
    end
  end

  def destroy
    user = User.find_by(name: params[:name])
    if user.destroy
      head :ok
    else
      render json: { response_type: "ephemeral", text: "Sorry, something went wrong. Please try again." }
    end
  end

  def allocate
    user = User.find_by(name: params[:user_name])
    project = Project.find_by(name: params[:project_name])
    if user.projects << project
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
