class Item < ActiveRecord::Base
  belongs_to :feed

  serialize :categories

  def self.create_from_rss(rss_item, parsed_feed)
    create! :title => rss_item.title, 
            :body => rss_item.content, 
            :published_date => (rss_item.published || parsed_feed.last_modified), 
            :link => rss_item.url,
            :categories => rss_item.categories
  end

  def <=> other
    published_date <=> other.published_date 
  end
end

# == Schema Information
#
# Table name: items
#
#  id             :integer         not null, primary key
#  feed_id        :integer
#  title          :string(255)
#  body           :text
#  shared         :boolean         default(FALSE)
#  created_at     :datetime
#  updated_at     :datetime
#  published_date :datetime
#  link           :string(255)
#  status_id      :string(255)
#  bitly_url      :string(255)
#  categories     :text
#

