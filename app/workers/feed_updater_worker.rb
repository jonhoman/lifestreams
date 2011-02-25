class FeedUpdaterWorker
  @queue = :feed_updating

  class << self
    def perform(feed_id, stream_id)
      feed = Feed.find(feed_id)
      stream = Stream.find(stream_id)
      parsed_feed = parse_feed!(feed, stream)
      items = parsed_feed.entries

      items.each do |rss_item|

        if feed.new_item?(rss_item)
          Rails.logger.debug "New item #{rss_item.title} for feed #{feed.name}, id: #{feed.id}"

          item = feed.items.create_from_rss(rss_item, parsed_feed) 

          # TODO: only grab active twitter accounts
          stream.twitter_accounts.each do |account|
            Resque.enqueue(TwitterUpdaterWorker, item.id, account.id)
          end

        elsif 
          Rails.logger.debug "Item #{rss_item.title} already exists for feed #{feed.name}, id: #{feed.id}"
        end
      end
    end

    private

    def parse_feed!(feed, stream)
      parsed_feed = Feedzirra::Feed.fetch_and_parse(feed.url)

      if !parsed_feed
        stream.update_attributes(:active => false)
        raise UnparsableFeedError.new
      end

      parsed_feed
    end

  end

  class UnparsableFeedError < StandardError; end
end
