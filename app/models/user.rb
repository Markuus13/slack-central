class User < ApplicationRecord
  has_and_belongs_to_many :projects, -> { distinct }
  validates :name, presence: true
end
