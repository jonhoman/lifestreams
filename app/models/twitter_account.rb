class TwitterAccount < ActiveRecord::Base
  scope :user, lambda { |user_id| where("user_id = ?", user_id) }

  validates_presence_of :handle, :access_token, :access_token_secret

  before_destroy :deactivate_stream

  def deactivate_stream
    streams = Stream.where(:twitter_account_id => id)
    streams.each { |s| s.update_attributes(:active => false) }
  end
end
