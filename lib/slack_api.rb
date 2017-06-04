require 'httparty'

class SlackAPI
  def self.respond_url(response_url, user_name)
    HTTParty.post(response_url, {
        body: {
          response_type: "in_channel",
          text: "@#{user_name} posted a new quote!",
          attachments: [{
            title: "Central Slack App",
            title_link: "https://central-slack.herokuapp.com/",
            text: "Check this and more of our quotes at https://central-slack.herokuapp.com/quotes :smile:",
          }]
        }.to_json,
        headers: { "Content-type": 'application/json' }
    })
  end
end
