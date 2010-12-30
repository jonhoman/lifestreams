require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

class Feed < ActiveRecord::Base

  def updated?
    true
    #TODO: get the first item in the feed and determine if the feed has been updated
  end
end
