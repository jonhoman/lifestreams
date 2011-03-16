class FacebookAccount < ActiveRecord::Base
  class << self
    def user(user_id)
      where(:user_id => user_id)
    end
  end
end
