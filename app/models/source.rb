class Source < ActiveRecord::Base
  has_many :destinations
  belongs_to :stream
end
