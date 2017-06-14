class UsersController < ApplicationController
  protect_from_forgery except: [:create]
  before_action :validate_slack_token, only: [:create, :destroy]

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

  private

  def project_params
    params.permit(:name)
  end
end
