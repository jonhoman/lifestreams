class Feed < ActiveRecord::Base
  scope :user, lambda { |user_id| where("user_id = ?", user_id) }

  has_many :items

  validates_presence_of :name, :url
  validates_format_of :url, :with => URI::regexp(%w(http https file))

  after_create :populate_items

  def recent_items
    item_list = items.sort! { |x,y| y <=> x }

    if item_list.count > 3
      item_list = item_list.take(3)
    end
    item_list
  end

  private

  def populate_items
    if ::Rails.env != "test"
      Resque.enqueue(FeedCreatorWorker, id)
    end
  end
end
