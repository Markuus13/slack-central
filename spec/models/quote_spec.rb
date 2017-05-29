require 'rails_helper'

RSpec.describe Quote, type: :model do
  subject(:quote) { Quote.new(author: "groot", text: "I'm groot.") }

  it "is valid with valid attributes" do
    expect(quote).to be_valid
  end

  it "is not valid without an author" do
    quote.author = nil
    expect(quote).to_not be_valid
  end

  it "is not valid without a text" do
    quote.text = nil
    expect(quote).to_not be_valid
  end
end
