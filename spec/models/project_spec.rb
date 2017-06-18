require 'rails_helper'

RSpec.describe Project, type: :model do
  subject(:project) { Project.new(name: "Some name") }

  it "is valid with valid attributes" do
    expect(project).to be_valid
  end

  it "is not valid without a name" do
    project.name = nil
    expect(project).to_not be_valid
  end
end
