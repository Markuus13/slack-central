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
      render json: response_quote(quote_params[:user_name]), status: 200
    else
      render json: { response_type: "ephemeral", text: "Sorry, something went wrong. Please try again." }
    end
  end

  private
  def valid_slack_token?
    quote_params[:token] == ENV["SLACK_AUTH_TOKEN"]
  end

  def quote_params
    params.permit(:token, :user_name, :text)
  end

  def response_quote(user_name)
    {
      response_type: "in_channel",
      text: "@#{user_name} posted a new quote!",
      attachments: [{
          title: "Central Slack App",
          title_link: "https://central-slack.herokuapp.com/",
          text: "Check this and more of our quotes at https://central-slack.herokuapp.com/quotes :smile:",
      }]
    }
  end
end
