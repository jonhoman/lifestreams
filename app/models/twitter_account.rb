class TwitterAccount < ActiveRecord::Base
  scope :user, lambda { |*args| {:conditions => ["user_id = ?", args.first] } }

  validates_presence_of :handle
  validates_presence_of :access_token
  validates_presence_of :access_token_secret
end
