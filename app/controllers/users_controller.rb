class UsersController < ApplicationController
  protect_from_forgery except: [:create]
  before_action :validate_slack_token, only: [:create, :destroy, :allocate]

  def create
    user = User.new(user_params)

    if user.save
      head :ok
    else
      render json: { response_type: "ephemeral", text: "Sorry, something went wrong. Please try again." }
    end
  end

  def destroy
    user = User.find_by(name: params[:text])
    if user.destroy
      head :ok
    else
      render json: { response_type: "ephemeral", text: "Sorry, something went wrong. Please try again." }
    end
  end

  def allocate
    user_name, project_name = parsed_params_text
    user = User.find_by(name: user_name)
    project = Project.find_by(name: project_name)
    if user.projects << project
      head :ok
    else
      render json: { response_type: "ephemeral", text: "Sorry, something went wrong. Please try again." }
    end
  end

  private

  def user_params
    { name: params.fetch(:text) }
  end

  def parsed_params_text
    params[:text].split
  end
end
