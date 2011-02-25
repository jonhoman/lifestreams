class Item < ActiveRecord::Base
  belongs_to :feed

  def self.create_from_rss(rss_item, parsed_feed)
    create!(:title => rss_item.title, :body => rss_item.content, :published_date => (rss_item.published || parsed_feed.last_modified), :link => rss_item.url)
  end

  def <=> other
    published_date <=> other.published_date 
  end
end
