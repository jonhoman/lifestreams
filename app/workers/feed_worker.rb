class FeedWorker
  @queue = :feed
  
  def self.perform(feed_id)
    feed = Feed.find(feed_id)
    retries = 0
    begin
      content = open(feed.url)
    rescue => e
      retries += 1
      retry unless retries > 1
      raise MaxRetriesError.new(e.message)
    end
    rss = RSS::Parser.parse(content, false)
    feed.update_attributes!(:name => rss.channel.title)
  end

  class MaxRetriesError < StandardError; end
end
