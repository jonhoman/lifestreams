class Stream < ActiveRecord::Base
  belongs_to :feed 
  belongs_to :twitter_account

  validates_presence_of :name
end
