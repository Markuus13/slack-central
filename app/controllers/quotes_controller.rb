class QuotesController < ApplicationController
  skip_before_action :verify_authenticity_token # Only for test purposes

  def index
    @quotes = Quote.last(5)
  end

  def create
    # test without token authentication 'D72oye7v7EFlS1PMpk25Ej0G'
    author = quote_params[:user_name]
    text = quote_params[:text]
    Quote.create!(author: author, text: text)
  end

  private
  def quote_params
    params.require(:token).permit(:team_id, :team_domain, :channel_id, :channel_name,
                                   :user_id, :user_name, :command, :text, :response_url)
  end
end
