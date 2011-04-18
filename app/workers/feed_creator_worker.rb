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

      create_items(feed.id, parsed_feed)

      title = parsed_feed.title
      feed.update_attributes! :title => title, 
                              :last_build_date => get_updated_date(parsed_feed).to_s,
                              :url => feed_url
    end

    private

    def get_updated_date(parsed_feed)
      parsed_feed.entries.first.published
    end

    def create_items(feed_id, parsed_feed)
      parsed_feed.entries.each do |item|
        #TODO: refactor this to use Item.create_from_rss
        Item.create!(
          :title => item.title, 
          :body => item.content, 
          :published_date => item.published,
          :link => item.url,
          :feed_id => feed_id, 
          :categories => item.categories 
        )
      end
    end
  end

  class MaxRetriesError < StandardError; end
end
