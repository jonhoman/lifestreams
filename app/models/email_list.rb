class EmailList < ActiveRecord::Base
  validates_presence_of :name
  has_and_belongs_to_many :streams

  before_save :parse_recipients!
  
  class << self
    def user(user_id)
      where(:user_id => user_id)
    end
  end

  private

  def parse_recipients!
    recipients.gsub!(/\n/, ",") if recipients
  end
end
