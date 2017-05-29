class Quote < ApplicationRecord
  alias_attribute :user_name, :author
  validates :author, presence: true
end
