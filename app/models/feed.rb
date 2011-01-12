class Feed < ActiveRecord::Base
  scope :user, lambda { |user_id| where("user_id = ?", user_id) }

  has_many :items
  has_and_belongs_to_many :streams

  validates_presence_of :name, :url
end
