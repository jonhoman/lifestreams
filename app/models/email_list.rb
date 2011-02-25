class EmailList < ActiveRecord::Base
  validates_presence_of :name
  has_and_belongs_to_many :streams
  
  class << self
    def user(user_id)
      where(:user_id => user_id)
    end
  end
end
