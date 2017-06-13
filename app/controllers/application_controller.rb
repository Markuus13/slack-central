class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def validate_slack_token
    render json: {}, status: :forbidden unless params[:token] == ENV["SLACK_AUTH_TOKEN"]
  end
end
