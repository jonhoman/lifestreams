class FacebookAccount < ActiveRecord::Base
  has_and_belongs_to_many :streams

  before_destroy :deactivate_stream

  def deactivate_stream
    streams.each do |stream| 
      if stream.facebook_accounts.count == 1 && stream.total_destination_count == 1 
        stream.update_attributes(:active => false)
      end
    end
  end

  class << self
    def user(user_id)
      where(:user_id => user_id)
    end
  end
end

# == Schema Information
#
# Table name: facebook_accounts
#
#  id           :integer         not null, primary key
#  access_token :string(255)
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#  facebook_id  :string(255)
#  link         :string(255)
#  name         :string(255)
#

