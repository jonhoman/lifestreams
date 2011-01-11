class Feed < ActiveRecord::Base
  scope :user, lambda { |*args| {:conditions => ["user_id = ?", args.first] } }

  has_many :items

  validates_presence_of :name
  validates_presence_of :url
end
