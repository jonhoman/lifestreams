class TwitterAccount < ActiveRecord::Base
  scope :user, lambda { |user_id| where("user_id = ?", user_id) }

  has_and_belongs_to_many :streams
  
  validates_presence_of :handle, :access_token, :access_token_secret

  before_destroy :deactivate_stream

  def deactivate_stream
    streams.each do |stream| 
      if stream.twitter_accounts.count == 1 && stream.total_destination_count == 1 
        stream.update_attributes(:active => false)
      end
    end
  end

  def name 
    self.handle
  end
end

# == Schema Information
#
# Table name: twitter_accounts
#
#  id                  :integer         not null, primary key
#  handle              :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  access_token        :string(255)
#  access_token_secret :string(255)
#  user_id             :integer
#  active              :boolean         default(TRUE)
#

