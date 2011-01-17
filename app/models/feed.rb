class Feed < ActiveRecord::Base
  scope :user, lambda { |user_id| where("user_id = ?", user_id) }

  has_many :items

  validates_presence_of :name, :url
  validates_format_of :url, :with => URI::regexp(%w(http https file))

  after_create :populate_items

  private

  def populate_items
    if ::Rails.env != "test"
      Resque.enqueue(FeedCreatorWorker, id)
    end
  end
end
