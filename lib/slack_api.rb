require 'httparty'

class SlackAPI
  def self.respond_url(content: nil, response_url: nil, user_name: nil)
    content ||= "@#{user_name} posted a new quote!"
    HTTParty.post(response_url, {
        body: {
          response_type: "in_channel",
          text: content,
          attachments: [{
            title: "Central Slack App",
            title_link: "https://central-slack.herokuapp.com/",
            text: "Check this and more of our quotes at https://central-slack.herokuapp.com/quotes :smile:",
          }]
        }.to_json,
        headers: { "Content-type": 'application/json' }
    })
  end

  def self.respond_projects(content, response_url, user_name)
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
