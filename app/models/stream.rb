class Stream < ActiveRecord::Base
  has_and_belongs_to_many :feeds
  has_and_belongs_to_many :twitter_accounts
end
