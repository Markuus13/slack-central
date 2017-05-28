# TODO Part of this controller will be refactored to /lib/slack_quotes.rb
require 'httparty'

class QuotesController < ApplicationController
  protect_from_forgery except: [:create]
  before_action :valid_slack_token?, only: [:create]

  def index
    @quote = Quote.last
  end

  def create
    quote = Quote.new(quote_params)

    if quote.save
      ActionCable.server.broadcast 'quotes', text: quote.text,
                                             author: quote.author
      success_response(params[:response_url], params[:user_name]) #TODO Replace with background job her
      head :ok
    else
      render json: { response_type: "ephemeral", text: "Sorry, something went wrong. Please try again." }
    end
  end

  private
  def valid_slack_token?
    unless quote_params[:token] == ENV["SLACK_AUTH_TOKEN"]
      render json: {}, status: 403
    end
  end

  def quote_params
    params.permit(:user_name, :text)
  end

  def success_response(response_url, user_name)
    HttParty.post(response_url, {
        body: {
          response_type: "in_channel",
          text: "#{user_name.capitalize} posted a new quote!",
          attachments: [{
            title: "Central Slack App",
            title_link: "https://central-slack.herokuapp.com/",
            text: "Check this and more of our quotes at https://central-slack.herokuapp.com/quotes :smile:",
          }]
        },
        headers: { "Content-type": 'application/json' }
    })
  end
end
