class TwitterAccount < ActiveRecord::Base
  scope :user, lambda { |user_id| where("user_id = ?", user_id) }

  has_many :destinations, :dependent => :destroy
  has_many :streams, :through => :destinations

  validates_presence_of :handle, :access_token, :access_token_secret

  before_destroy :deactivate_stream

  def deactivate_stream
    destinations.each { |d| d.stream.update_attributes(:active => false) }
  end
end
