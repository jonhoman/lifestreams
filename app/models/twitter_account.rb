class TwitterAccount < ActiveRecord::Base
  scope :user, lambda { |user_id| where("user_id = ?", user_id) }

  has_and_belongs_to_many :streams

  validates_presence_of :handle, :access_token, :access_token_secret
end
