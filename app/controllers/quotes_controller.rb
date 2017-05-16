class QuotesController < ApplicationController

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
    quote_params[:token] == 'D72oye7v7EFlS1PMpk25Ej0G'
  end

  def quote_params
    params.permit(:token, :user_name, :text)
  end
end
