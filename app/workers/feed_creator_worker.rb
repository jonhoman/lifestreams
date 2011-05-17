class FeedCreatorWorker
  @queue = :feed_creation
 
  class << self
    def perform(feed_id)
      feed = Feed.find(feed_id)
      feed_url = feed.determine_feed_url
      retries = 0
      begin
        parsed_feed = Feedzirra::Feed.fetch_and_parse(feed_url)
      rescue => e
        retries += 1
        retry unless retries > 1
        raise MaxRetriesError.new(e.message)
      end

      create_items(feed, parsed_feed)

      title = parsed_feed.title
      feed.update_attributes! :title => title, 
                              :last_build_date => get_updated_date(parsed_feed).to_s,
                              :url => feed_url
    end

    private

    def get_updated_date(parsed_feed)
      parsed_feed.entries.first.published
    end

    def create_items(feed, parsed_feed)
      parsed_feed.entries.each do |item|
        feed.items.create_from_rss(item, parsed_feed)
      end
    end
  end

  class MaxRetriesError < StandardError; end
end
