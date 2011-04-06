class FeedUpdaterWorker
  @queue = :feed_updating

  class << self
    def perform(stream_id, feed_id)
      stream = Stream.find(stream_id)
      feed = Feed.find(feed_id)
      parsed_feed = parse_feed!(feed, stream)
      items = parsed_feed.entries

      items.each do |rss_item|

        if feed.new_item?(rss_item)
          Rails.logger.debug "New item #{rss_item.title} for feed #{feed.name}, id: #{feed.id}"

          item = feed.items.create_from_rss(rss_item, parsed_feed) 

          enqueue(stream, item)

        else 
          Rails.logger.debug "Item #{rss_item.title} already exists for feed #{feed.name}, id: #{feed.id}"
        end
      end
    end

    private
    
    def enqueue(stream, item)
      if category_matches?(stream, item)
        # TODO: only grab active twitter accounts
        stream.twitter_accounts.each do |account|
          Resque.enqueue(TwitterUpdaterWorker, item.id, account.id)
        end

        stream.email_lists.each do |list|
          Resque.enqueue(EmailWorker, item.id, list.id)
        end

        stream.facebook_accounts.each do |account|
          Resque.enqueue(FacebookUpdaterWorker, item.id, account.id)
        end
      end
    end

    def parse_feed!(feed, stream)
      parsed_feed = Feedzirra::Feed.fetch_and_parse(feed.url)

      if !parsed_feed || parsed_feed == 0
        stream.update_attributes(:active => false)
        raise UnparsableFeedError.new
      end

      parsed_feed
    end

    def category_matches?(stream, item)
      result = true # if the stream doesn't define categories to include, assume all categories

      if stream.included_categories.present?
        stream_categories = stream.included_categories.split(",").collect { |str| str.strip }
        item_categories = item.categories

        item_categories.each do |item_category|
          if stream_categories.include?(item_category)
            result = true
            break;
          end
        result = false
        end
      end
      result
    end

  end

  class UnparsableFeedError < StandardError; end
end
