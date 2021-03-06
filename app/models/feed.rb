class Feed < ActiveRecord::Base
  has_many :items
  has_and_belongs_to_many :streams

  validates_presence_of :name, :url
  validates_format_of :url, :with => URI::regexp(%w(http https file))

  after_create :populate_items
  before_destroy :deactivate_stream

  def recent_items
    item_list = items.sort! { |x,y| y <=> x }

    item_list.take(3)
  end

  def deactivate_stream
    streams.each { |s| s.update_attributes(:active => false) }
  end
  
  def determine_feed_url
    # stupid testing hack
    if url == "file://#{Rails.root.to_s}/spec/data/feed.rss" || url == "file://#{Rails.root.to_s}/spec/data/feed-small.rss"
      return url 
    end

    urls = Feedbag.find(url)
    self.url = urls[0]
  end

  def new_item?(rss_item) 
    items.where(:title => rss_item.title).count == 0
  end

  private

  def populate_items
    if ::Rails.env != "test"
      Resque.enqueue(FeedCreatorWorker, id)
    end
  end

end

# == Schema Information
#
# Table name: feeds
#
#  id              :integer         not null, primary key
#  url             :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  name            :string(255)
#  last_build_date :datetime
#  user_id         :integer
#  title           :string(255)
#

