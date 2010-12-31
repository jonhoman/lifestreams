class FeedWorker
  @queue = :feed
 
  class << self
    def perform(feed_id)
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
      name = rss.channel.title

      feed.update_attributes!(:name => name, :last_build_date => get_updated_date(rss).to_s )
    end

    private

    def get_updated_date(rss)
      # some feeds don't have LastBuildDate, use the first items pubDate instead
      (rss.channel.lastBuildDate) || (rss.items.first.pubDate)
    end
  end

  class MaxRetriesError < StandardError; end
end
