class Stream < ActiveRecord::Base
  scope :user, lambda { |user_id| where("user_id = ?", user_id) }
  scope :all_active, Stream.where("feed_id > ?", 0).where("twitter_account_id > ?", 0).
    where("active = ?", true)

  belongs_to :feed 
  has_many :destinations, :dependent => :destroy
  has_many :twitter_accounts, :through => :destinations

  validates_presence_of :name
end
