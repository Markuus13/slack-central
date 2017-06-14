class QuotesController < ApplicationController
  protect_from_forgery except: [:create]
  before_action :validate_slack_token, only: [:create]

  def index
    @quote = Quote.last
  end

  def create
    quote = Quote.new(quote_params)

    if quote.save
      ActionCable.server.broadcast 'quotes', text: quote.text,
                                             author: quote.author
      SlackAPI.respond_url(params[:response_url], params[:user_name])
      head :ok
    else
      render json: { response_type: "ephemeral", text: "Sorry, something went wrong. Please try again." }
    end
  end

  private

  def quote_params
    params.permit(:user_name, :text)
  end
end
