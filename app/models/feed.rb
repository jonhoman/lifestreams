class Feed < ActiveRecord::Base
  scope :user, lambda { |user_id| where("user_id = ?", user_id) }

  has_many :items

  validates_presence_of :name, :url

  after_create :populate_items

  private

  def populate_items
    Resque.enqueue(FeedCreatorWorker, id)
  end
end
