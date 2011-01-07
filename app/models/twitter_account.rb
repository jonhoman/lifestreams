class TwitterAccount < ActiveRecord::Base
  validates_presence_of :handle
  validates_presence_of :access_token
  validates_presence_of :access_token_secret
end
