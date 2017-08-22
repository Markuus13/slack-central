class Project < ApplicationRecord
  has_and_belongs_to_many :users, -> { distinct }
  validates :name, presence: true

  def self.format_message
    message = "`Projetos em andamento:\n"
    all.each do |project|
      message += "\t- #{project.name}:\n"
      project.users.each {|user| message += "\t\t- #{user.name}\n"}
    end
    message +="`"
    message
  end
end
