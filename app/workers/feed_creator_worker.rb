class FeedCreatorWorker
  @queue = :feed_creation
 
  class << self
    def perform(feed_id)
      feed = Feed.find(feed_id)
      retries = 0
      begin
        parsed_feed = Feedzirra::Feed.fetch_and_parse(feed.url)
      rescue => e
        retries += 1
        retry unless retries > 1
        raise MaxRetriesError.new(e.message)
      end

      create_items(feed.id, parsed_feed)

      name = parsed_feed.title
      feed.update_attributes!(:name => name, :last_build_date => get_updated_date(parsed_feed).to_s )
    end

    private

    def get_updated_date(parsed_feed)
      parsed_feed.entries.first.published
    end

    def create_items(feed_id, parsed_feed)
      parsed_feed.entries.each do |item|
        Item.create!(
          :title => item.title, 
          :body => item.content, 
          :published_date => item.published,
          :link => item.url,
          :feed_id => feed_id
        )
      end
    end
  end

  class MaxRetriesError < StandardError; end
end
