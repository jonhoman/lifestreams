class Source < ActiveRecord::Base
  has_many :destinations
  has_one :stream
  accepts_nested_attributes_for :destinations
end
