class Destination < ActiveRecord::Base
  belongs_to :stream
  belongs_to :twitter_account
end
