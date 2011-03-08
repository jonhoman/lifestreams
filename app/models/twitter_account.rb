class TwitterAccount < ActiveRecord::Base
  scope :user, lambda { |user_id| where("user_id = ?", user_id) }

  has_and_belongs_to_many :streams
  
  validates_presence_of :handle, :access_token, :access_token_secret

  before_destroy :deactivate_stream

  def deactivate_stream
    streams.each do |stream| 
      if stream.twitter_accounts.count == 1 && stream.email_lists.count == 0 
        stream.update_attributes(:active => false)
      end
    end
  end
end
