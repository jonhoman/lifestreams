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
        if i.count == 0
          unknown_count += 1 
          Item.create!(:feed_id => feed_id, :title => item.title, :body => item.description, :published_date => item.pubDate.to_s, :link => item.link)
        end
      end
      feed.update_attributes(:new_items => (unknown_count > 0))
    end
  end
end
