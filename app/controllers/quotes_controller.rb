class QuotesController < ApplicationController
  protect_from_forgery except: :create

  def index
    @quote = Quote.last
  end

  def create
    return render json: {}, status: 403 unless valid_slack_token?

    quote = Quote.new
    quote.author = quote_params[:user_name]
    quote.text = quote_params[:text]

    if quote.save
      ActionCable.server.broadcast 'quotes', text: quote.text,
                                             author: quote.author
      head :ok
    end
  end

  private
  def valid_slack_token?
    quote_params[:token] == ENV["SLACK_AUTH_TOKEN"]
  end

  def quote_params
    params.permit(:token, :user_name, :text)
  end
end
