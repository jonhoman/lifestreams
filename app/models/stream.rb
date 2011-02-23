class Stream < ActiveRecord::Base
  belongs_to :feed 
  has_and_belongs_to_many :twitter_accounts
  
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
