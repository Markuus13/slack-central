class Quote < ApplicationRecord
  alias_attribute :user_name, :author
end
