class Feed < ActiveRecord::Base
  scope :user, lambda { |user_id| where("user_id = ?", user_id) }

  has_many :items

  validates_presence_of :name
  validates_presence_of :url
end
