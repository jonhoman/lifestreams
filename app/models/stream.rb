class Stream < ActiveRecord::Base
  scope :user, lambda { |user_id| where("user_id = ?", user_id) }

  belongs_to :feed 
  belongs_to :twitter_account

  validates_presence_of :name
end
