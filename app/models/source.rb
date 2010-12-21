class Source < ActiveRecord::Base
  has_many :destinations
  belongs_to :stream
  accepts_nested_attributes_for :destinations
end
