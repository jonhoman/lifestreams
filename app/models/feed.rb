class Feed < ActiveRecord::Base
  has_many :items

  def updated?
    true
    #TODO: get the first item in the feed and determine if the feed has been updated
  end
end
