class Stream < ActiveRecord::Base
  belongs_to :feed 
  has_and_belongs_to_many :twitter_accounts
  has_and_belongs_to_many :email_lists
  has_and_belongs_to_many :facebook_accounts
  
  validates_presence_of :name

  def total_destination_count
    twitter_accounts.count + facebook_accounts.count + email_lists.count
  end

  class << self
    def user(user_id)
      where(:user_id => user_id)
    end

    def all_active
      where("feed_id > ?", 0).where("active = ?", true).reject { |s| s.twitter_accounts.empty? && s.email_lists.empty?}
    end
  end
end
