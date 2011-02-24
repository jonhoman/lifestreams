class EmailList < ActiveRecord::Base
  validates_presence_of :name
  
  class << self
    def user(user_id)
      where(:user_id => user_id)
    end
  end
end
