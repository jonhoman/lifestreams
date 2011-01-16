class FeedUpdaterWorker
  @queue = :feed_updating

  class << self
    def perform(feed_id, twitter_account_id)
      feed = Feed.find(feed_id)

      #TODO: consider passing in all feed url's here
      parsed_feed = Feedzirra::Feed.fetch_and_parse(feed.url)

      items = parsed_feed.entries
      unknown_count = 0

      items.each do |rss_item|
        i = Item.where(:feed_id => feed_id, :title => rss_item.title)
        if i.count == 0
          Rails.logger.debug "New item #{rss_item.title} for feed #{feed.name}, id: #{feed.id}"
          unknown_count += 1 
          item = Item.create!(:feed_id => feed_id, :title => rss_item.title, :body => rss_item.content, :published_date => rss_item.published, :link => rss_item.url)
          Resque.enqueue(TwitterUpdaterWorker, item.id, twitter_account_id)
        elsif 
          Rails.logger.debug "Item #{rss_item.title} already exists for feed #{feed.name}, id: #{feed.id}"
        end
      end
      feed.update_attributes!(:new_items => (unknown_count > 0))
    end
  end
end
