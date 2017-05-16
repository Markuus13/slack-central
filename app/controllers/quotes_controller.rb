class QuotesController < ApplicationController
  protect_from_forgery except: :create

  def index
    @quotes = Quote.last(5)
  end

  def create
    return render json: {}, status: 403 unless valid_slack_token?

    author = quote_params[:user_name]
    text = quote_params[:text]
    Quote.create!(author: author, text: text)
  end

  private
  def valid_slack_token?
    quote_params[:token] == ENV["SLACK_AUTH_TOKEN"]
  end

  def quote_params
    params.permit(:token, :user_name, :text)
  end
end
