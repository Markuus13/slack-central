require 'rails_helper'

RSpec.describe Quote, type: :model do
  subject(:valid_quote) { Quote.new(author: "marcus") }

  it "is valid with valid attributes" do
    expect(valid_quote).to be_valid
  end

  it "is not valid without an author" do
    quote = Quote.new(author: nil)
    expect(quote).to_not be_valid
  end
end
