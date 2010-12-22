class Source < ActiveRecord::Base
  belongs_to :stream
  has_many :destinations
  accepts_nested_attributes_for :destinations
end
