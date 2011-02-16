class Stream < ActiveRecord::Base

  belongs_to :feed 
  has_many :destinations, :dependent => :destroy
  has_many :twitter_accounts, :through => :destinations

  validates_presence_of :name

  class << self
    def user(user_id)
      where(:user_id => user_id)
    end

    def all_active
      where("feed_id > ?", 0).where("active = ?", true).reject { |s| s.twitter_accounts.empty? }
    end
  end
end
