class User < ApplicationRecord
  scope(:created_after, ->(date) { where("created_at < ?", "#{date}") })
end
