class Feed < ActiveRecord::Base
  has_many :items
end
