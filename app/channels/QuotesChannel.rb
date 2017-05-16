class QuotesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'quotes'
  end
end
