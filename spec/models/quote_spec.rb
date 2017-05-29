require 'rails_helper'

RSpec.describe Quote, type: :model do

  it "is valid with valid attributes" do
    expect(Quote.new).to be_valid
  end
end
