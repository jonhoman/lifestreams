class FeedUpdaterWorker
  @queue = :feed_updating

  class << self
    def perform(feed_id)
      feed = Feed.find(feed_id)

      rss = RSS::Parser.parse(open(feed.url), false)
      items = rss.items

      unknown_count = 0
      items.each do |item|
        i = Item.where(:feed_id => feed_id, :title => item.title)
        unknown_count += 1 if i.count == 0
      end

      feed.update_attributes(:new_items => false) if unknown_count == 0
    end
  end
end
