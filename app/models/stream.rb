class Stream < ActiveRecord::Base
  has_and_belongs_to_many :feeds 
  has_and_belongs_to_many :twitter_accounts
  has_and_belongs_to_many :email_lists
  has_and_belongs_to_many :facebook_accounts
  
  validates_presence_of :name

  def total_destination_count
    twitter_accounts.count + facebook_accounts.count + email_lists.count
  end

  class << self
    def all_active
      where("active = ?", true).reject { |s| s.total_destination_count == 0 }
    end
  end
end

# == Schema Information
#
# Table name: streams
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  user_id             :integer
#  active              :boolean         default(TRUE)
#  included_categories :string(255)
#

