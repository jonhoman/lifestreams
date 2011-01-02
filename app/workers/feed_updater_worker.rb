class FeedUpdaterWorker
  @queue = :feed_updating

  class << self
    def perform(feed_id)
      feed = Feed.find(feed_id)

      rss = RSS::Parser.parse(open(feed.url), false)
      items = rss.items

      unknown_count = 0
      items.each do |rss_item|
        i = Item.where(:feed_id => feed_id, :title => rss_item.title)
        if i.count == 0
          unknown_count += 1 
          item = Item.create!(:feed_id => feed_id, :title => rss_item.title, :body => rss_item.description, :published_date => rss_item.pubDate.to_s, :link => rss_item.link)
          Resque.enqueue(TwitterUpdaterWorker, item.id)
        end
      end
      feed.update_attributes!(:new_items => (unknown_count > 0))
    end
  end
end
